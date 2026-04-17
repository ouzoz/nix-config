{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # tex
    texliveFull
    plantuml
    graphviz

    android-tools
  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  users.users.ouz.extraGroups = [
    #adb
    "kvm"
    "libvirtd"

    #wireshark
    "wireshark"
  ];
}
