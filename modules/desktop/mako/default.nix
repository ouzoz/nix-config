{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mako
  ];

  environment.etc = {
    "xdg/mako/config".source = ./config;
  };

  systemd.user.services.mako = {
    description = "Mako notification daemon";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "mako";
      Restart = "on-failure";
      Slice = "session.slice";
    };
  };
}
