{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    brightnessctl
  ];

  imports = [
    ./thunar.nix
    ./foot.nix

    ./fuzzel.nix
    ./swaybg.nix
    ./hyprlock.nix
    ./waybar.nix
    ./mako.nix

    ./clipboard.nix
    ./sound.nix
    ./cursor.nix
    ./fonts.nix

    ./hyprland
    ./niri.nix
  ];
}
