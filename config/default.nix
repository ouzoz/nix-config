{ config, lib, ... }:

let
  cfg = config.my;
in
{
  options.my = {
    theme.wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../wallpapers/default.jpg;
      description = "Default wallpaper used by swaybg.";
    };

    theme.wallpaperMode = lib.mkOption {
      type = lib.types.enum [ "stretch" "fill" "fit" "center" "tile" ];
      default = "fill";
    };

    layout.gaps = lib.mkOption {
      type = lib.types.int;
      default = 8;
    };
  };
}
