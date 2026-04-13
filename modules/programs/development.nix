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
  users.users.ouz.extraGroups = [ "wireshark" ];

  virtualisation.libvirtd.enable = true;
  users.users.ouz.extraGroups = [ "kvm" "adbusers" "libvirtd" ];
  programs.adb.enable = true;
}
