{ ... }:

{
  imports = [
    ../modules/desktop/fonts.nix
    ../modules/desktop/cursor.nix
    ../modules/desktop/waybar.nix
    ../modules/desktop/sound.nix
    ../modules/desktop/mako.nix
    ../modules/desktop/hypr

    ../modules/programs/gui.nix
    ../modules/programs/obs.nix
  ];
}
