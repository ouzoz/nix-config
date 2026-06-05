{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
  ];

  systemd.user.services.cliphist = {
    description = "Cliphist clipboard history";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.cliphist}/bin/cliphist";
      Restart = "on-failure";
      Slice = "session.slice";
    };
  };

  environment.sessionVariables = {
    CLIPHIST_CONFIG_PATH = "/etc/xdg/cliphist/config";
  };

  environment.etc."xdg/cliphist/config".text = ''
    max-items 600
    preview-width 24
  '';

  # cliphist list | fuzzel --dmenu | cliphist decode | wl-copy
}
