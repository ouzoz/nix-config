{ ... }:

{
  imports = [
    ../modules/desktop/fonts.nix
    ../modules/desktop/cursor.nix
    ../modules/desktop/mako.nix
    ../modules/desktop/hypr
    ../modules/desktop/waybar

    ../modules/programs/gui.nix
  ];
}
