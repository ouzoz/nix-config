{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # utils
    just
    ripgrep

    # lsp
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

    # tex
    texliveFull
    plantuml
    graphviz

    android-tools
  ];

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
