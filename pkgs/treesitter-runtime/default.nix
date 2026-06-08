{
  lib,
  runCommand,
  vimPlugins,
  pkgs,
  ...
}:

let

  getLang =
    pkg:
    let
      name = pkg.pname or (builtins.parseDrvName pkg.name).name;
      stripped = lib.removePrefix "tree-sitter-" name;
    in
    builtins.replaceStrings [ "-" ] [ "_" ] stripped;
in
runCommand "treesitter-runtime" { } ''
  mkdir -p $out/parser
  mkdir -p $out/queries
  ${lib.concatMapStrings (pkg: ''
    lang=${getLang pkg}
    ln -s ${pkg}/parser $out/parser/$lang.so

    if [ -d ${vimPlugins.nvim-treesitter.src}/runtime/queries/$lang ]; then
      ln -s ${vimPlugins.nvim-treesitter.src}/runtime/queries/$lang $out/queries/$lang
    fi
  '') 
  [
    pkgs.tree-sitter-bash
    pkgs.tree-sitter-cmake
    pkgs.tree-sitter-cpp
    pkgs.tree-sitter-css
    pkgs.tree-sitter-csv
    pkgs.tree-sitter-cuda
    pkgs.tree-sitter-dockerfile
    pkgs.tree-sitter-dot
    pkgs.tree-sitter-embedded-template
    # pkgs.tree-sitter-git-config
    # pkgs.tree-sitter-git-rebase
    # pkgs.tree-sitter-gitattributes
    # pkgs.tree-sitter-gitcommit
    # pkgs.tree-sitter-gitignore
    pkgs.tree-sitter-go
    pkgs.tree-sitter-html
    pkgs.tree-sitter-ini
    pkgs.tree-sitter-java
    pkgs.tree-sitter-javascript
    pkgs.tree-sitter-json
    pkgs.tree-sitter-julia
    pkgs.tree-sitter-just
    pkgs.tree-sitter-latex
    pkgs.tree-sitter-log
    pkgs.tree-sitter-make
    pkgs.tree-sitter-nix
    pkgs.tree-sitter-opencl
    pkgs.tree-sitter-php
    pkgs.tree-sitter-python
    pkgs.tree-sitter-rust
    pkgs.tree-sitter-sql
    pkgs.tree-sitter-toml
    pkgs.tree-sitter-tsx
    pkgs.tree-sitter-typescript
    pkgs.tree-sitter-xml
    pkgs.tree-sitter-yaml
  ]
}
''
