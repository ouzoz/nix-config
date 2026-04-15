{ pkgs }:

let
  parsers = with pkgs.tree-sitter-grammars; [
    tree-sitter-ada
    tree-sitter-agda
    tree-sitter-awk
    tree-sitter-bash
    tree-sitter-bibtex
    tree-sitter-c
    tree-sitter-c-sharp
    tree-sitter-cairo
    tree-sitter-clojure
    tree-sitter-cmake
    tree-sitter-comment
    tree-sitter-commonlisp
    tree-sitter-cpp
    tree-sitter-crystal
    tree-sitter-css
    tree-sitter-csv
    tree-sitter-cuda
    tree-sitter-d
    tree-sitter-dart
    tree-sitter-debian
    tree-sitter-devicetree
    tree-sitter-diff
    tree-sitter-dockerfile
    tree-sitter-dot
    tree-sitter-edoc
    tree-sitter-elisp
    tree-sitter-elixir
    tree-sitter-elm
    tree-sitter-embedded-template
    tree-sitter-erlang
    tree-sitter-fish
    tree-sitter-fortran
    tree-sitter-fsharp
    tree-sitter-fstar
    tree-sitter-git-config
    tree-sitter-git-rebase
    tree-sitter-gitattributes
    tree-sitter-gitcommit
    tree-sitter-gitignore
    tree-sitter-gleam
    tree-sitter-go
    tree-sitter-graphql
    tree-sitter-groovy
    tree-sitter-haskell
    tree-sitter-hcl
    tree-sitter-hjson
    tree-sitter-html
    tree-sitter-htmldjango
    tree-sitter-http
    tree-sitter-hyprlang
    tree-sitter-ini
    tree-sitter-java
    tree-sitter-javascript
    tree-sitter-jq
    tree-sitter-jsdoc
    tree-sitter-json
    tree-sitter-julia
    tree-sitter-just
    tree-sitter-kotlin
    tree-sitter-latex
    tree-sitter-llvm
    tree-sitter-log
    tree-sitter-mail
    tree-sitter-make
    tree-sitter-markdoc
    tree-sitter-markdown
    tree-sitter-markdown-inline
    tree-sitter-matlab
    tree-sitter-meson
    tree-sitter-nginx
    tree-sitter-nim
    tree-sitter-nix
    tree-sitter-ocaml
    tree-sitter-odin
    tree-sitter-opencl
    tree-sitter-pascal
    tree-sitter-perl
    tree-sitter-php
    tree-sitter-phpdoc
    tree-sitter-powershell
    tree-sitter-prolog
    tree-sitter-proto
    tree-sitter-python
    tree-sitter-ql
    tree-sitter-query
    tree-sitter-r
    tree-sitter-readline
    tree-sitter-regex
    tree-sitter-river
    tree-sitter-ruby
    tree-sitter-rust
    tree-sitter-scala
    tree-sitter-scheme
    tree-sitter-solidity
    tree-sitter-sql
    tree-sitter-strace
    tree-sitter-svelte
    tree-sitter-sway
    tree-sitter-swift
    tree-sitter-tablegen
    tree-sitter-todotxt
    tree-sitter-toml
    tree-sitter-tsq
    tree-sitter-tsx
    tree-sitter-typescript
    tree-sitter-v
    tree-sitter-vala
    tree-sitter-verilog
    tree-sitter-vhdl
    tree-sitter-vim
    tree-sitter-vue
    tree-sitter-xml
    tree-sitter-yaml
    tree-sitter-zig
  ];

  getLang = pkg:
    let
      name = pkg.pname or (builtins.parseDrvName pkg.name).name;
      stripped = pkgs.lib.removePrefix "tree-sitter-" name;
    in
      builtins.replaceStrings ["-"] ["_"] stripped;
in

pkgs.runCommand "treesitter-runtime" { } ''
  mkdir -p $out/parser
  mkdir -p $out/queries
  ${pkgs.lib.concatMapStrings (pkg: ''
    ln -s ${pkg}/parser $out/parser/${getLang pkg}.so
  '') parsers}
  ln -s ${pkgs.vimPlugins.nvim-treesitter.src}/runtime/queries/* $out/queries/
''
