{ pkgs, ... }:

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

  queries = pkgs.runCommand "treesitter-queries-only" {} ''
    mkdir -p $out/queries
    cp -r ${pkgs.vimPlugins.nvim-treesitter.src}/runtime/queries/* $out/queries/
  '';
in
{
  programs.neovim.configure = {
    packages.treesitter-bundle = {
      start = parsers ++ [ queries ];
    };
  };
}
