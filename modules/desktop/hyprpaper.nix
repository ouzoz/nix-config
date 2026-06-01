{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  systemd.user.services.hyprpaper = {
    description = "hyprpaper service";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
      Slice = "session.slice";
    };
  };

  environment.etc."xdg/hypr/hyprpaper.conf".text = ''
    splash = false
    wallpaper {
      monitor =
      path = /etc/nixos/assets/wallpaper/city-manhattan.jpg
    }
  '';
}
