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
  ];
  # system.userActivationScripts.linkOpencode = {
  # };
  programs.wireshark.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.adb.enable = true;
  users.users.ouz.extraGroups = [
    #adb
    "kvm"
    "adbusers"
    "libvirtd"

    #wireshark
    "wireshark"
  ];
}
