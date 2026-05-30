{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    vscode-langservers-extracted
    docker-language-server
    just-lsp
    lua-language-server
    marksman
    nixd
    sqls
    texlab
    yaml-language-server
  ];
}
