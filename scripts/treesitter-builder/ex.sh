#!/bin/bash

FLAG_DOWNLOAD='--reload'
INPUTS='./parsers.txt'
WORK_DIR="$(pwd)"
REPOS_DIR="$WORK_DIR/repos"
PARSER_DIR="$WORK_DIR/parser"
QUERIES_DIR="$WORK_DIR/queries"
LOG_FILE="$WORK_DIR/out.log"
EXTENSION=".so"

log() {
    echo "$@" >> "$LOG_FILE"
}

run_cmd() {
    "$@" >> "$LOG_FILE" 2>&1
}
export -f run_cmd

check_dependencies() {
    local dependencies=("tree-sitter" "git" "nm")
    for cmd in "${dependencies[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "Error: Required command '$cmd' is not installed."
            exit 1
        fi
    done
}

clean_dir() {
    if [ -d "$1" ]; then
        rm -rf "$1"
    fi
    mkdir -p "$1"
}

echo "--- Tree-sitter Builder Log $(date) --- " > "$LOG_FILE"

check_dependencies

download_repos() {
    echo ">> [MODE] Download & Rebuild"
    echo ">> Cleaning repositories directory..."
    clean_dir "$REPOS_DIR"
    echo ""

    echo ">> Cloning nvim-treesitter for fallback queries..."
    printf "  %-30s " "Cloning nvim-treesitter..."
    if run_cmd git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter "$REPOS_DIR/.nvim-treesitter"; then
        echo "[OK]"
    else
        echo "[FAIL] (See out.log)"
    fi
    echo ""

    echo ">> Cloning repositories from $INPUTS (Parallel)..."

    export REPOS_DIR LOG_FILE
    do_clone() {
        repo=$1
        name=$(basename "$repo" .git)
        if run_cmd git clone --depth 1 "$repo" "$REPOS_DIR/$name"; then
            printf "  [OK] %-30s\n" "$name"
        else
            printf "  [FAIL] %-30s (See out.log)\n" "$name"
        fi
    }
    export -f do_clone

    grep -cve '^\s*$' "$INPUTS" | xargs -I {} echo "Starting {} clones..."
    grep -v '^\s*$' "$INPUTS" | xargs -P 10 -I {} bash -c 'do_clone "{}"'
}

if [[ "${1:-}" == $FLAG_DOWNLOAD ]]; then
    download_repos
else
    echo ">> [MODE] Build Only (Use --reload to redownload)"
fi

print_and_log() {
    echo "$1"
    log "$1"
}

build_grammars() {
    echo ">> Cleaning output directories..."
    clean_dir "$PARSER_DIR"
    clean_dir "$QUERIES_DIR"

    echo ">> Copying base queries from nvim-treesitter..."
    if [ -d "$REPOS_DIR/.nvim-treesitter/runtime/queries" ]; then
        cp -r "$REPOS_DIR/.nvim-treesitter/runtime/queries/"* "$QUERIES_DIR/"
    fi

    echo ">> Starting Build Process (Parallel)..."
    echo "   Detailed logs: $LOG_FILE"
    echo "============================================================"

    STATUS_DIR=$(mktemp -d)
    
    export REPOS_DIR PARSER_DIR QUERIES_DIR EXTENSION LOG_FILE STATUS_DIR

    process_grammar() {
        GRAMMAR_FILE="$1"
        
        REPO_DIR=$(dirname "$GRAMMAR_FILE")
        REPO_BASENAME=$(basename "$REPO_DIR")

        if [[ "$REPO_BASENAME" == *tree-sitter-* ]]; then
            PARSER_NAME="${REPO_BASENAME##*tree-sitter-}"
        else
            PARSER_NAME="$REPO_BASENAME"
        fi

        PARSER_NAME="${PARSER_NAME//-/_}"
        PARSER_NAME=$(echo "$PARSER_NAME" | tr '[:upper:]' '[:lower:]')

        if [[ "$REPO_DIR" == *".nvim-treesitter"* ]]; then
            return
        fi

        DIR_NAME="$PARSER_NAME"
        OUTPUT_LIB="$PARSER_DIR/${DIR_NAME}${EXTENSION}"
        
        if ! pushd "$REPO_DIR" > /dev/null; then
            echo "$DIR_NAME:DIR_ERR:NONE" > "$STATUS_DIR/$DIR_NAME"
            return
        fi

        BUILD_STATUS="PENDING"
        
        if run_cmd tree-sitter build -o "$OUTPUT_LIB"; then
            BUILD_STATUS="OK"
        else
            if run_cmd tree-sitter generate && run_cmd tree-sitter build -o "$OUTPUT_LIB"; then
                BUILD_STATUS="GEN"
            else
                BUILD_STATUS="FAIL"
                echo "$DIR_NAME:FAIL:NONE" > "$STATUS_DIR/$DIR_NAME"
                popd > /dev/null
                printf "  [FAIL] %-20s\n" "$DIR_NAME"
                return
            fi
        fi

        if [ -f "$OUTPUT_LIB" ]; then
            SYM_NAME=$(nm -D "$OUTPUT_LIB" | awk '/ T tree_sitter_/ { print $3 }' | sed 's/^tree_sitter_//' | head -n 1 | tr '[:upper:]' '[:lower:]')
            
            if [[ -n "$SYM_NAME" && "$SYM_NAME" != "$DIR_NAME" ]]; then
                NEW_OUTPUT_LIB="$PARSER_DIR/${SYM_NAME}${EXTENSION}"
                mv "$OUTPUT_LIB" "$NEW_OUTPUT_LIB"
                OUTPUT_LIB="$NEW_OUTPUT_LIB"
                PARSER_NAME="$SYM_NAME"
            else
                PARSER_NAME="$DIR_NAME"
            fi
        fi

        QUERIES_SRC="queries"
        QUERIES_DEST="$QUERIES_DIR/$PARSER_NAME"
        
        NVIM_SRC_DIR="$REPOS_DIR/.nvim-treesitter/runtime/queries/$DIR_NAME"
        NVIM_SRC_SYM="$REPOS_DIR/.nvim-treesitter/runtime/queries/$PARSER_NAME"
        
        QUERY_STATUS="----"
        if [ -d "$NVIM_SRC_DIR" ]; then
            QUERY_STATUS="NVIM"
        elif [ -d "$NVIM_SRC_SYM" ]; then
            QUERY_STATUS="NVIM"
        elif [ -d "$QUERIES_SRC" ]; then
            mkdir -p "$QUERIES_DEST"
            cp -r "$QUERIES_SRC/"* "$QUERIES_DEST/"
            QUERY_STATUS="REPO"
        fi
        
        echo "$DIR_NAME:$BUILD_STATUS:$QUERY_STATUS" > "$STATUS_DIR/$DIR_NAME"
        printf "  [%4s] %-20s\n" "$BUILD_STATUS" "$PARSER_NAME"

        popd > /dev/null
    }
    export -f process_grammar

    CORES=4
    if command -v nproc > /dev/null; then
        CORES=$(nproc)
    fi

    find "$REPOS_DIR" -maxdepth 3 -name "grammar.js" -print0 | xargs -0 -P "$CORES" -I {} bash -c 'process_grammar "{}"'

    LIST_GENERATED=()
    LIST_FAILED=()
    LIST_UPSTREAM=()
    
    for f in "$STATUS_DIR"/*; do
        [ -e "$f" ] || continue
        IFS=':' read -r name build_status query_status < "$f"
        
        if [[ "$build_status" == "GEN" ]]; then
            LIST_GENERATED+=("$name")
        elif [[ "$build_status" == "FAIL" ]]; then
            LIST_FAILED+=("$name")
        elif [[ "$build_status" == "DIR_ERR" ]]; then
            LIST_FAILED+=("$name (Dir Error)")
        fi
        
        if [[ "$query_status" == "REPO" ]]; then
            LIST_UPSTREAM+=("$name")
        fi
    done
    
    rm -rf "$STATUS_DIR"

    PARSERS_SORTED=$(find "$PARSER_DIR" -maxdepth 1 -name "*$EXTENSION" -printf "%f\n" | sed "s/$EXTENSION$//" | sort)
    QUERIES_SORTED=$(find "$QUERIES_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort)

    MISSING_QUERIES=$(comm -23 <(echo "$PARSERS_SORTED") <(echo "$QUERIES_SORTED"))
    
    COUNT_MISSING_QUERIES=$(echo "$MISSING_QUERIES" | grep -v "^$" | wc -l)
    
    IFS=$'\n' LIST_UPSTREAM_SORTED=($(sort <<<"${LIST_UPSTREAM[*]}"))
    unset IFS

    print_and_log ""
    print_and_log "=============================================================================="
    print_and_log "Total Parsers Built:      $(echo "$PARSERS_SORTED" | grep -v "^$" | wc -l)"
    print_and_log "Total Queries Extracted:  $(echo "$QUERIES_SORTED" | grep -v "^$" | wc -l)"
    
    print_and_log "1. GENERATED PARSERS (${#LIST_GENERATED[@]}):"
    if [ ${#LIST_GENERATED[@]} -gt 0 ]; then
        for item in "${LIST_GENERATED[@]}"; do
             echo "   - $item" | tee -a "$LOG_FILE"
        done
    else
        print_and_log "   (None)"
    fi

    print_and_log "2. FAILED BUILDS (${#LIST_FAILED[@]}):"
    if [ ${#LIST_FAILED[@]} -gt 0 ]; then
        for item in "${LIST_FAILED[@]}"; do
             echo "   - $item" | tee -a "$LOG_FILE"
        done
    else
        print_and_log "   (None)"
    fi

    print_and_log "3. PARSERS WITHOUT QUERIES ($COUNT_MISSING_QUERIES):"
    if [ "$COUNT_MISSING_QUERIES" -gt 0 ]; then
        echo "$MISSING_QUERIES" | sed 's/^/   - /' | tee -a "$LOG_FILE"
    else
        print_and_log "   (None)"
    fi

    print_and_log "4. QUERIES EXTRACTED FROM UPSTREAM (${#LIST_UPSTREAM_SORTED[@]}):"
    if [ ${#LIST_UPSTREAM_SORTED[@]} -gt 0 ]; then
        for item in "${LIST_UPSTREAM_SORTED[@]}"; do
             echo "   - $item" | tee -a "$LOG_FILE"
        done
    else
        print_and_log "   (None)"
    fi
}

build_grammars
