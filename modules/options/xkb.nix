{ lib, ... }: {
  options.my.xkb = {
    layout = lib.mkOption {
      type = lib.types.str;
      default = "tr,us";
      description = "xkb settings.";
    };
    options = lib.mkOption {
      type = lib.types.str;
      default = "caps:swapescape,grp:win_space_toggle";
      description = "xkb options.";
    };
  };
}
