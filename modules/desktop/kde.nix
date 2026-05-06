{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;

  services.displayManager.plasma-login-manager.enable = true;

  environment.systemPackages = with pkgs; [ wl-clipboard ];
}
