{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      wl-clipboard
      cliphist
    ];

    sessionVariables = {
      CLIPHIST_CONFIG_PATH = "/etc/xdg/cliphist/config";
    };

    etc."xdg/cliphist/config".text = ''
      max-items 600
      preview-width 60
    '';
  };

  systemd.user.services.cliphist = {
    description = "Cliphist clipboard history";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
      Slice = "session.slice";
    };
  };
}
