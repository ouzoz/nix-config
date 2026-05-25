{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.target = "graphical-session.target";
  };

  environment.etc = {
    "xdg/waybar/config.jsonc".source = ./config.jsonc;
    "xdg/waybar/style.css".source = ./style.css;
  };
}
