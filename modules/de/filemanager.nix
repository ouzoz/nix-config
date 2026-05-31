{ pkgs, ... }:
{
  programs.thunar.enable = true;
  environment.systemPackages = with pkgs; [
    pcmanfm
  ];
}
