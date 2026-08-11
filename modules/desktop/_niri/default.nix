_:

{
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  environment = {
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ] \
        && [ "$USER" = "ouz" ] \
        && [ -z "$DISPLAY" ] \
        && [ -z "$WAYLAND_DISPLAY" ] \
      ; then
        exec niri-session -l
      fi
    '';

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      #   QT_QPA_PLATFORM = "wayland";
      #   SDL_VIDEODRIVER = "wayland";
      #   CLUTTER_BACKEND = "wayland";
    };

    etc."niri/config.kdl".source = ./config.kdl;
  };
}
