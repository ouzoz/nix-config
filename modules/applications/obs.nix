{ config, lib, ... }:
{
  options.my.mod.applications = {
    obs.enable = lib.mkEnableOption "obs studio";
  };

  config = lib.mkIf config.my.mod.applications.obs.enable {
    programs.obs-studio.enable = true;
  };
}
