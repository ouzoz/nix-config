{ ... }:
{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  # environment.systemPackages = with pkgs; [ wl-clipboard ];
  #
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.sessionVariables = {
  #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  #   QT_QPA_PLATFORM = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   CLUTTER_BACKEND = "wayland";
  #   MOZ_ENABLE_WAYLAND = "1";
    COSMIC_DATA_CONTROL_ENABLED = "1";
  };
}
