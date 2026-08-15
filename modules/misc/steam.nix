{ config, lib, ... }:

let
  cfg = config.my.misc;
in
{
  options.my.misc.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.steam.enable { programs.steam.enable = true; };
}
