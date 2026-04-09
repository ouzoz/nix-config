# { pkgs, ... }:
#
# let
#   parsers = with pkgs.tree-sitter-grammars; [
#     tree-sitter-bash
#     tree-sitter-c
#     tree-sitter-cpp
#     tree-sitter-css
#     tree-sitter-html
#     tree-sitter-javascript
#     tree-sitter-json
#     tree-sitter-lua
#     tree-sitter-markdown
#     tree-sitter-markdown-inline
#     tree-sitter-nix
#     tree-sitter-python
#     tree-sitter-rust
#     tree-sitter-toml
#     tree-sitter-yaml
#   ];
#
#   merged-parsers = pkgs.symlinkJoin {
#     name = "treesitter-parsers";
#     paths = parsers;
#   };
# in
#
# pkgs.runCommand "treesitter-native-runtime" {} ''
#   mkdir -p $out
#   ln -s ${merged-parsers}/parser $out/parser
#   ln -s ${pkgs.vimPlugins.nvim-treesitter.src}/runtime/queries $out/queries
# ''

{ pkgs }:

let
  parsers = with pkgs.tree-sitter-grammars; [
    tree-sitter-bash
    tree-sitter-c
    tree-sitter-cpp
    tree-sitter-css
    tree-sitter-html
    tree-sitter-javascript
    tree-sitter-json
    tree-sitter-lua
    tree-sitter-markdown
    tree-sitter-markdown-inline
    tree-sitter-nix
    tree-sitter-python
    tree-sitter-rust
    tree-sitter-toml
    tree-sitter-yaml
  ];

  getLang = pkg: pkgs.lib.removePrefix "tree-sitter-" (pkg.pname or (builtins.parseDrvName pkg.name).name);
in

pkgs.runCommand "treesitter-runtime" { } ''
  mkdir -p $out/parser
  mkdir -p $out/queries
  ${pkgs.lib.concatMapStrings (pkg: ''
    ln -s ${pkg}/parser $out/parser/${getLang pkg}.so
  '') parsers}
  ln -s ${pkgs.vimPlugins.nvim-treesitter.src}/runtime/queries/* $out/queries/
''
