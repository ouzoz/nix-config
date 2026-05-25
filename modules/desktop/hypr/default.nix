{ lib, pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  environment.loginShellInit = ''
    if [ "$USER" = "ouz" ] \
      && [ -z "$DISPLAY" ] \
      && [ -z "$WAYLAND_DISPLAY" ] \
      && [ "$(tty)" = "/dev/tty1" ] \
      && uwsm check may-start \
    ; then
      exec uwsm start hyprland.desktop
    fi
  '';

  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStart = lib.mkForce [
      ""
      "${pkgs.util-linux}/bin/agetty -o '-- ouz' --skip-login --noreset --noclear tty1 $TERM"
    ];
  };

  # services.getty = {
  #   loginOptions = "-- ouz";
  #   extraArgs = [
  #     "--skip-login"
  #       "--noreset"
  #       "--noclear"
  #   ];
  # };

  security.polkit.enable = true;
  systemd.user.services.hyprpolkitagent = {
    description = "Hyprland Polkit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      Slice = "session.slice";
      TimeoutStopSec = "5sec";
    };
  };

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

  environment.systemPackages = with pkgs; [
    apple-cursor
    grim
    slurp
    wl-clipboard

    hyprpaper
    hyprpicker
    hyprlauncher
    hyprpolkitagent
    hyprpwcenter
    hyprshutdown
    hyprtoolkit
  ];

  environment.etc = {
    "xdg/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
    "xdg/hypr/hyprland.lua".source = ./hyprland.lua;

    "xdg/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    "xdg/hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
    "xdg/hypr/hyprlauncher.conf".source = ./hyprlauncher.conf;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="nvidia", SYMLINK+="dri/by-driver/nvidia-card"
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="i915", SYMLINK+="dri/by-driver/intel-card"
  '';

  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/by-driver/nvidia-card:/dev/dri/by-driver/intel-card";
    NIXOS_OZONE_WL = "1";

    XCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "16";
#   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
#   QT_QPA_PLATFORM = "wayland";
#   SDL_VIDEODRIVER = "wayland";
#   CLUTTER_BACKEND = "wayland";

# env = LIBVA_DRIVER_NAME,nvidia
# env = GBM_BACKEND,nvidia-drm
# env = __GLX_VENDOR_LIBRARY_NAME,nvidia
# env = NVD_BACKEND,direct
  };
}
