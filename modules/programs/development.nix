{ config, pkgs, ... }:

{
  # environment.sessionVariables = {
  # };
  # environment.shellAliases = {
  # };
  environment.systemPackages = with pkgs; [
      texliveFull
      plantuml
      graphviz

      pylyzer
      clang-tools
      lua-language-server
      nixd
      typescript-language-server

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
