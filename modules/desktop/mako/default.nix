{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mako
    libnotify
  ];

  environment.etc = {
    "xdg/mako/config".source = ./config;
  };

  systemd.user.services.mako = {
    enable = true;
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
