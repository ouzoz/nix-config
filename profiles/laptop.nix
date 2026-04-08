{ config, pkgs, ... }:

{
  imports = [
    ../modules/desktop/sway/sway.nix
    ../modules/desktop/fonts.nix

    ../modules/programs/gui.nix
  ];
}
