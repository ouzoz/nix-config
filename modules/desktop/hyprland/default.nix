{ pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  environment.etc = {
    "xdg/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
    "xdg/hypr/hyprland.lua".source = ./hyprland.lua;

    "xdg/hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
  };
}
