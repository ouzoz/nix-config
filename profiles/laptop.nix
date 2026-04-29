{ config, pkgs, ... }:

{
  imports = [
    # ../modules/desktop/cosmic.nix
    ../modules/desktop/fonts.nix
    ../modules/desktop/kde.nix

    ../modules/programs/gui.nix
  ];
}
