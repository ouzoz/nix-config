{ pkgs, ... }:
{
  imports = [
    ./thunar.nix
    ./foot.nix

    ./fuzzel.nix
    ./swaybg.nix
    ./hyprlock.nix
    ./waybar.nix
    ./mako.nix

    ./clipboard.nix
    ./sound.nix
    ./cursor.nix
    ./fonts.nix

    ./niri.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   CLUTTER_BACKEND = "wayland";
  };

  # systemd.services."getty@tty1" = {
  #   overrideStrategy = "asDropin";
  #   serviceConfig.ExecStart = lib.mkForce [
  #     ""
  #     "${pkgs.util-linux}/bin/agetty -o '-- ouz' --skip-login --noreset --noclear tty1 $TERM"
  #   ];
  # };

  # services.getty = {
  #   loginOptions = "-- ouz";
  #   extraArgs = [
  #     "--skip-login"
  #       "--noreset"
  #       "--noclear"
  #   ];
  # };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        # gtk-theme = "Adwaita";
        # icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Source Sans 3 12";
        document-font-name = "Source Sans 3 12";
        monospace-font-name = "Oziosevka 12";
      };
    }
  ];

  # xdg-desktop-portal-gnome xdg-desktop-portal-gtk
}
