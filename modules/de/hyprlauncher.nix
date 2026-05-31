{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprlauncher
  ];

  environment.etc."xdg/hypr/hyprlauncher.conf".text = ''
    ui {
      window_size = 600, 360
    }
  '';
}
