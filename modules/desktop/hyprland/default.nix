{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
  #       gtk-theme = "Adwaita";
  #       icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Source Sans 3 12";
        document-font-name = "Source Sans 3 12";
        monospace-font-name = "Oziosevka 12";
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    waybar
  #   wofi
    mako
    grim
    slurp

    hyprpaper
    hyprlauncher
    hyprlock
    hyprsysteminfo
    hyprpolkitagent
    hyprpwcenter
    hyprshutdown
    hyprtoolkit
    hyprcursor

    wl-clipboard
  ];

  environment.etc = {
    "xdg/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
    "xdg/hypr/hyprland.lua".source = ./hyprland.lua;

    "xdg/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    "xdg/hypr/hyprtoolkit.conf".source = ./hyprtoolkit.conf;
    "xdg/hypr/hyprlauncher.conf".source = ./hyprlauncher.conf;

    "xdg/waybar/config.jsonc".source = ./waybar/config.jsonc;
    "xdg/waybar/style.css".source = ./waybar/style.css;

    "xdg/mako/config".source = ./mako/config;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="nvidia", SYMLINK+="dri/by-driver/nvidia-card"
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="i915", SYMLINK+="dri/by-driver/intel-card"
  '';

  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/by-driver/nvidia-card:/dev/dri/by-driver/intel-card";
#   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
#   QT_QPA_PLATFORM = "wayland";
#   SDL_VIDEODRIVER = "wayland";
#   CLUTTER_BACKEND = "wayland";
#   MOZ_ENABLE_WAYLAND = "1";

# env = LIBVA_DRIVER_NAME,nvidia
# env = XDG_SESSION_TYPE,wayland
# env = GBM_BACKEND,nvidia-drm
# env = __GLX_VENDOR_LIBRARY_NAME,nvidia
# env = NVD_BACKEND,direct
  };

  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.greetd.enableGnomeKeyring = true;
  # programs.sway = {
  #   enable = true;
  #   extraOptions = [ "--unsupported-gpu" ];
  #   wrapperFeatures.gtk = true;
  # };
  #
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     initial_session = {
  #       command = "${pkgs.sway}/bin/sway --unsupported-gpu";
  #       user = "ouz"; 
  #     };
  #     default_session = {
  #       command = "${pkgs.sway}/bin/sway --unsupported-gpu";
  #       user = "ouz"; 
  #     };
  #   };
  # };
}
