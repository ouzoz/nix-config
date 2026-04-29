{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  services.xserver.enable = true;

  # services.displayManager.plasma-login-manager.enable = true;

  environment.systemPackages = with pkgs; [ wl-clipboard ];

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
