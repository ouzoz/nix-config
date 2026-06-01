{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    vscode-langservers-extracted
    docker-language-server
    just-lsp
    marksman
    sqls
    texlab
    yaml-language-server
  ];
}
