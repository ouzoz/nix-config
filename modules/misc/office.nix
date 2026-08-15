{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.my.misc;
in
{
  options.my.misc = {
    office.enable = lib.mkEnableOption "Libreoffice";
  };

  config = lib.mkIf cfg.office.enable { environment.systemPackages = with pkgs; [ libreoffice ]; };
}
