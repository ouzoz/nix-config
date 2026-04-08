{ config, pkgs, ... }:

{
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  systemd.user.services.solaar = {
    enable = true;
    description = "Solaar background service";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.solaar}/bin/solaar --window=hide";
    };
  };
}
