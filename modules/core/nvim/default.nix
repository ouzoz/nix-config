{ pkgs, ... }:

let
  treesitter-runtime = pkgs.callPackage ../../../packages/treesitter-runtime {
    parsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-bash
      tree-sitter-c-sharp
      tree-sitter-cmake
      tree-sitter-cpp
      tree-sitter-css
      tree-sitter-csv
      tree-sitter-cuda
      tree-sitter-dockerfile
      tree-sitter-dot
      tree-sitter-embedded-template
      tree-sitter-git-config
      tree-sitter-git-rebase
      tree-sitter-gitattributes
      tree-sitter-gitcommit
      tree-sitter-gitignore
      tree-sitter-go
      tree-sitter-haskell
      tree-sitter-html
      tree-sitter-ini
      tree-sitter-java
      tree-sitter-javascript
      tree-sitter-json
      tree-sitter-julia
      tree-sitter-just
      tree-sitter-latex
      tree-sitter-llvm
      tree-sitter-log
      tree-sitter-make
      tree-sitter-nix
      tree-sitter-ocaml
      tree-sitter-opencl
      tree-sitter-php
      tree-sitter-powershell
      tree-sitter-python
      tree-sitter-r
      tree-sitter-rust
      tree-sitter-sql
      tree-sitter-toml
      tree-sitter-tsx
      tree-sitter-typescript
      tree-sitter-xml
      tree-sitter-yaml
    ];
  };
in
{
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    runtime = {
      "init.lua".source = ./init.lua;
      "lua".source = ./lua;
      "lsp".source = ./lsp;
      "spell".source = ./spell;
      "parser".source = "${treesitter-runtime}/parser";
      "queries".source = "${treesitter-runtime}/queries";
    };
  };
}
