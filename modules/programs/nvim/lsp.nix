{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    basedpyright
    bash-language-server
    cmake-language-server
    vscode-langservers-extracted
    docker-language-server
    java-language-server
    just-lsp
    lua-language-server
    marksman
    nixd
    sqls
    texlab
    typescript-language-server
    yaml-language-server
  ];
}
