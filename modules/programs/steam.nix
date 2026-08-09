{ config, lib, ... }:

let
  cfg = config.my.mod.programs;
in
{
  options.my.mod.programs.steam.enable = lib.mkEnableOption "Steam";
  config = lib.mkIf cfg.steam.enable { programs.steam.enable = true; };
}
