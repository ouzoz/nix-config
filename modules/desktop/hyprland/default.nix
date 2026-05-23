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

  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="nvidia", SYMLINK+="dri/by-driver/nvidia-card"
    SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="i915", SYMLINK+="dri/by-driver/intel-card"
  '';

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/by-driver/nvidia-card:/dev/dri/by-driver/intel-card";
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
#     (import ./waybar/default.nix {inherit pkgs colors;})
#     (import ./hypridle.nix)
#     (import ./hyprlock.nix)
#   ];
#   wayland = {
#     windowManager = {
#       hyprland = {
#         enable = true;
#         package = pkgs.hyprland;
#         configType = "lua";
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
#         systemd = { enable = true; };
#         xwayland = { enable = true; };
#       };
#     };
#   };
#   home.file = {
#     ".local/share/scripts/fuzzy-bookmarks.lua" = {
#       source = ./scripts/fuzzy-bookmarks.lua;
#     };
#     ".local/share/scripts/toggle-mute.lua" = {
#       source = ./scripts/toggle-mute.lua;
#     };
#     ".local/share/wallpapers/" = {
#       source = ./../../../assets/wallpapers;
#       recursive = true;
#     };
#     ".local/share/scripts/screenshot.sh" = {
#       text = ''
#         ${pkgs.grim}/bin/grim \
#           -g "$(${pkgs.slurp}/bin/slurp)" - \
#           | ${pkgs.satty}/bin/satty \
#             --filename - \
#             --output-filename "/home/${username}/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
#       '';
#     };
#     ".local/share/scripts/screen-record.sh" = {
#       text = ''
#         if pidof wl-screenrec; then
#           pkill wl-screenrec;
#         else
#           ${pkgs.wl-screenrec}/bin/wl-screenrec \
#             --dri-device /dev/dri/card1 \
#             -g "$(${pkgs.slurp}/bin/slurp)" \
#             --filename "/home/${username}/screenshots/screenrec-$(date '+%Y%m%d-%H:%M:%S').mp4";
#         fi
#       '';
#     };
#   };
# }
