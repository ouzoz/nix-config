{ pkgs, ... }:

{
  hardware.logitech.wireless.enable = true;
  programs.solaar.enable = true;
  systemd.user.services.solaar = {
    description = "Solaar background service";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.solaar}/bin/solaar --window=hide";
    };
  };
}
