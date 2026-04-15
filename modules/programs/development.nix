{ config, pkgs, ... }:

{
  # environment.sessionVariables = {
  # };
  # environment.shellAliases = {
  # };
  environment.systemPackages = with pkgs; [
    # utils
    just
    ripgrep

    # lsp
    clang-tools
    lua-language-server
    nixd
    just-lsp
    bash-language-server
    typescript-language-server
    marksman
    yaml-language-server
    vscode-langservers-extracted
    cmake-language-server
    texlab
    basedpyright
    java-language-server
    docker-language-server
    sqls

    # tex
    texliveFull
    plantuml
    graphviz

    # docker
    # docker-compose

    android-tools
  ];
  # system.userActivationScripts.linkOpencode = {
  # };

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  programs.wireshark.dumpcap.enable = true;

  virtualisation.libvirtd.enable = true;

  users.users.ouz.extraGroups = [
    #adb
    "kvm"
    "libvirtd"

    #wireshark
    "wireshark"
  ];
}
