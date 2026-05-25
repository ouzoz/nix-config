{ ... }:

{
  imports = [
    ../modules/desktop/fonts.nix
    ../modules/desktop/hypr
    ../modules/desktop/waybar
    ../modules/desktop/mako

    ../modules/programs/gui.nix
  ];
}
