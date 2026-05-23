{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # programs.dconf.profiles.user.databases = [
  #   {
  #     settings."org/gnome/desktop/interface" = {
  #       gtk-theme = "Adwaita";
  #       icon-theme = "Flat-Remix-Red-Dark";
  #       font-name = "Noto Sans Medium 11";
  #       document-font-name = "Noto Sans Medium 11";
  #       monospace-font-name = "Noto Sans Mono Medium 11";
  #     };
  #   }
  # ];

  environment.systemPackages = with pkgs; [
    wl-clipboard
    waybar
  #   wofi
    mako
    grim
    slurp
  ];

  environment.etc = {
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

# { pkgs, pkgs-stable, username, main_monitor, monitor_prefix, resolution, scale, colors, ... }: 
# let
#   cursorTheme = if colors.theme == "dark" then "Capitaine Cursors (Gruvbox) - White" else "Capitaine Cursors (Gruvbox)";
#   wallpaper = if colors.theme == "dark" then "midnight-reflections-moonlit-sea.jpg" else "mountains-with-sky.jpg";
#   luajit = import ../../langs/luajit.nix {inherit pkgs;};
# in {
#   imports = [
#     (import ./hypridle.nix)
#     (import ./hyprlock.nix)
#   ];
#   wayland = {
#     windowManager = {
#       hyprland = {
#         extraConfig =
#           builtins.replaceStrings
#           [
#             "@LUAJIT@"
#             "@ROFI_POWER_MENU@"
#             "@WALLPAPER@"
#             "@CURSOR_THEME@"
#             "@RESOLUTION@"
#             "@SCALE@"
#             "@MAIN_MONITOR@"
#             "@MONITOR_PREFIX@"
#           ]
#           [
#             "${luajit}/bin/luajit"
#             "${pkgs.rofi-power-menu}/bin/rofi-power-menu"
#             "${wallpaper}"
#             "${cursorTheme}"
#             "${resolution}"
#             "${toString scale}"
#             "${main_monitor}"
#             "${monitor_prefix}"
#           ]
#           (builtins.readFile ./config.lua);
#       };
#     };
#   };
# }
