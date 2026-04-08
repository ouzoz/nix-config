{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    libreoffice
    # obsidian
    # thunderbird
  ];
}
