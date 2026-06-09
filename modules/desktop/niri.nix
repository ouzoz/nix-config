{ ... }:
{
  programs.niri.enable = true;

  environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ] \
      && [ "$USER" = "ouz" ] \
      && [ -z "$DISPLAY" ] \
      && [ -z "$WAYLAND_DISPLAY" ] \
    ; then
      exec niri-session -l
    fi
  '';

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   CLUTTER_BACKEND = "wayland";
  };

  environment.etc."niri/config.kdl".text = ''
    prefer-no-csd
    screenshot-path "~/Pictures/Screenshot_%Y-%m-%d_%H-%M-%S.png"

    cursor {
      hide-when-typing
      xcursor-theme "macOS"
      xcursor-size 20
    }

    overview {
      zoom 0.42
      backdrop-color "#777777"
      workspace-shadow {
        off
      }
    }

    clipboard {
      disable-primary
    }

    hotkey-overlay {
      skip-at-startup
    }

    blur {
      passes 1
      offset 3
      noise 0.02
      saturation 1.5
    }

    input {
        keyboard {
            repeat-rate 60
            repeat-delay 240

            xkb {
                layout "tr,us"
                options "caps:swapescape,grp:win_space_toggle"
            }
        }

        mouse {
            natural-scroll
            accel-speed 1
            accel-profile "adaptive"
            middle-emulation
            scroll-factor 1.0
        }

        touchpad {
            tap
            dwt
            dwtp
            natural-scroll
            accel-speed 0.3
            accel-profile "flat"
            middle-emulation
            scroll-factor 1.0
            disabled-on-external-mouse
        }

        disable-power-key-handling
        warp-mouse-to-focus mode="center-xy-always"
        focus-follows-mouse
        // focus-follows-mouse max-scroll-amount="0%" // Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
        workspace-auto-back-and-forth

        mod-key "Super"
        mod-key-nested "Alt"
    }

    /-output "eDP-1" {
        mode "1920x1080@165"
        scale 1
        transform "normal"
        position x=0 y=0
    }

    output "eDP-1" {
        off
    }

    output "HDMI-A-1" {
        mode "1920x1080@180"
        scale 1
        transform "normal"
        position x=0 y=0
        focus-at-startup
    }

    /-output "HDMI-A-1" {
        off
    }

    /-switch-events {
      lid-close { spawn "notify-send" "The laptop lid is closed!"; }
      lid-open { spawn "notify-send" "The laptop lid is open!"; }
    }

    layout {
        gaps 10
        center-focused-column "on-overflow"
        always-center-single-column
        default-column-display "normal"
        background-color "transparent"

        default-column-width { proportion 0.5; }
        // default-column-width { }
        preset-column-widths {
            proportion 0.25
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
            proportion 1.0
        }

        // default-window-height { }
        preset-window-heights {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
          proportion 1.0
        }

        focus-ring {
            width 2
            active-color "#7fc8ff"
            inactive-color "#505050"
            urgent-color "#9b0000"
        }

        border {
            off
        }

        tab-indicator {
            hide-when-single-tab
        }

        insert-hint {
          // off
          color "#ffc87f80"
        }

        struts {
            // left 64
            // right 64
            // top 64
            // bottom 64
        }
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    /-window-rule {
        match app-id=r#"^org\.keepassxc\.KeePassXC$"#
        match app-id=r#"^org\.gnome\.World\.Secrets$"#
        block-out-from "screen-capture"
    }

    /-window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }

    layer-rule {
        match namespace="^wallpaper$"
        place-within-backdrop true
    }

    window-rule {
      match app-id="^foot$"
        background-effect {
          blur true
        }
    }

    window-rule {
      draw-border-with-background false
    }

    layer-rule {
      match namespace="^launcher$"

        // xray true
        geometry-corner-radius 12
        background-effect {
          blur true
        }
    }

    animations {
      workspace-switch {
        off
      }
      window-open {
        duration-ms 120
        curve "ease-out-expo"
      }
      window-close {
        duration-ms 120
        curve "ease-out-quad"
      }
      horizontal-view-movement {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }
      window-movement {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }
      window-resize {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }
      config-notification-open-close {
        off
      }
      exit-confirmation-open-close {
        spring damping-ratio=0.6 stiffness=500 epsilon=0.01
      }
      screenshot-ui-open {
        off
      }
      overview-open-close {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }
      recent-windows-close {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.001
      }
    }

    gestures {
      dnd-edge-view-scroll {
        trigger-width 30
        delay-ms 100
        max-speed 1500
      }

      dnd-edge-workspace-switch {
        trigger-height 50
        delay-ms 100
        max-speed 1500
      }

      hot-corners {
        // off
        bottom-left
      }
    }

    recent-windows {
      debounce-ms 0
      open-delay-ms 0

      highlight {
        active-color "#999999ff"
        urgent-color "#ff9999ff"
        padding 30
        corner-radius 12
      }

      previews {
        max-height 480
        max-scale 0.5
      }

      binds {
        Mod+quotedbl { next-window scope="output"; }
        Mod+Shift+quotedbl { previous-window scope="output"; }
      }
    }

    binds {
        Mod+Return                        { spawn "foot"; }
        Mod+I                             { spawn "thunar"; }

        Mod+BackSpace                     { spawn "fuzzel"; }
        Mod+C                             { spawn-sh "cliphist list | fuzzel --dmenu --width 60 | cliphist decode | wl-copy"; }
        Mod+N                             { spawn-sh "top -b -o +RES -n 1 -Em -em | head -n 60 | fuzzel --dmenu --width 96"; }
        Mod+Escape                        { spawn-sh "selected=$(printf '%s\n' '⎋ Lock' '🆥 Monitors' '⏼ Reboot' '⏻ Shutdown' '⏾ Suspend' '⏎ Exit' | fuzzel --dmenu); case \"$selected\" in '⎋ Lock') hyprlock ;; '🆥 Monitors') niri msg action power-off-monitors ;; '⏼ Reboot') systemctl reboot ;; '⏻ Shutdown') systemctl poweroff ;; '⏾ Suspend') systemctl suspend-then-hibernate ;; '⏎ Exit') niri msg action quit ;; esac"; }

        Mod+U                             { spawn "hyprpicker"; }

        Mod+P                             { screenshot; }
        Mod+Shift+P                       { screenshot-screen; }
        Mod+Ctrl+P                        { screenshot-window; }

        Mod+S repeat=false                { toggle-overview; }
        Mod+Q repeat=false                { close-window; }
        Ctrl+Alt+Delete                   { quit; }
        Mod+Delete                        allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+H                             { focus-column-left; }
        Mod+J                             { focus-window-down; }
        Mod+K                             { focus-window-up; }
        Mod+L                             { focus-column-right; }
        Mod+Shift+H                       { move-column-left; }
        Mod+Shift+J                       { move-window-down; }
        Mod+Shift+K                       { move-window-up; }
        Mod+Shift+L                       { move-column-right; }

        Mod+Ctrl+H                        { focus-monitor-left; }
        Mod+Ctrl+J                        { focus-monitor-down; }
        Mod+Ctrl+K                        { focus-monitor-up; }
        Mod+Ctrl+L                        { focus-monitor-right; }
        Mod+Ctrl+Shift+H                  { move-workspace-to-monitor-left; }
        Mod+Ctrl+Shift+J                  { move-workspace-to-monitor-down; }
        Mod+Ctrl+Shift+K                  { move-workspace-to-monitor-up; }
        Mod+Ctrl+Shift+L                  { move-workspace-to-monitor-right; }

        // Mod+Shift+U                    { move-workspace-down; }
        // Mod+Shift+I                    { move-workspace-up; }
        // Mod+U                          { focus-workspace-down; }
        // Mod+idotless                   { focus-workspace-up; }
        // Mod+Ctrl+U                     { move-column-to-workspace-down; }
        // Mod+Ctrl+idotless              { move-column-to-workspace-up; }

        Mod+O                             { consume-or-expel-window-left; }
        Mod+Shift+O                       { consume-or-expel-window-right; }

        Mod+W                             { switch-preset-column-width; }
        Mod+Shift+W                       { switch-preset-column-width-back; }
        Mod+E                             { switch-preset-window-height; }
        Mod+Shift+E                       { switch-preset-window-height-back; }

        Mod+F                             { maximize-column; }
        Mod+Shift+F                       { fullscreen-window; }
        Mod+Ctrl+F                        { expand-column-to-available-width; }
        Mod+M                             { maximize-window-to-edges; }

        Mod+Y                             { toggle-window-floating; }
        Mod+Shift+Y                       { switch-focus-between-floating-and-tiling; }
        Mod+T                             { toggle-column-tabbed-display; }

        Mod+WheelScrollDown               cooldown-ms=60 { focus-workspace-down; }
        Mod+WheelScrollUp                 cooldown-ms=60 { focus-workspace-up; }
        Mod+WheelScrollRight              { focus-column-right; }
        Mod+WheelScrollLeft               { focus-column-left; }
        Mod+Shift+WheelScrollDown         { focus-column-right; }
        Mod+Shift+WheelScrollUp           { focus-column-left; }

        Mod+Tab                           { focus-workspace-previous; }
        Mod+1                             { focus-workspace 1; }
        Mod+2                             { focus-workspace 2; }
        Mod+3                             { focus-workspace 3; }
        Mod+4                             { focus-workspace 4; }
        Mod+5                             { focus-workspace 5; }
        Mod+6                             { focus-workspace 6; }
        Mod+7                             { focus-workspace 7; }
        Mod+8                             { focus-workspace 8; }
        Mod+9                             { focus-workspace 9; }
        Mod+Shift+1                       { move-window-to-workspace 1; }
        Mod+Shift+2                       { move-window-to-workspace 2; }
        Mod+Shift+3                       { move-window-to-workspace 3; }
        Mod+Shift+4                       { move-window-to-workspace 4; }
        Mod+Shift+5                       { move-window-to-workspace 5; }
        Mod+Shift+6                       { move-window-to-workspace 6; }
        Mod+Shift+7                       { move-window-to-workspace 7; }
        Mod+Shift+8                       { move-window-to-workspace 8; }
        Mod+Shift+9                       { move-window-to-workspace 9; }
        Mod+Ctrl+1                        { move-column-to-workspace 1; }
        Mod+Ctrl+2                        { move-column-to-workspace 2; }
        Mod+Ctrl+3                        { move-column-to-workspace 3; }
        Mod+Ctrl+4                        { move-column-to-workspace 4; }
        Mod+Ctrl+5                        { move-column-to-workspace 5; }
        Mod+Ctrl+6                        { move-column-to-workspace 6; }
        Mod+Ctrl+7                        { move-column-to-workspace 7; }
        Mod+Ctrl+8                        { move-column-to-workspace 8; }
        Mod+Ctrl+9                        { move-column-to-workspace 9; }

        Mod+Minus                         allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        Mod+Period                        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        Mod+Right                         allow-when-locked=true { spawn-sh "playerctl next"; }
        Mod+Left                          allow-when-locked=true { spawn-sh "playerctl previous"; }
        Mod+Up                            allow-when-locked=true { spawn-sh "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 6%+"; }
        Mod+Down                          allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%-"; }

        XF86AudioRaiseVolume              allow-when-locked=true allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
        XF86AudioLowerVolume              allow-when-locked=true allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
        XF86AudioMute                     allow-when-locked=true allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute                  allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        XF86AudioPlay                     allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop                     allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev                     allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext                     allow-when-locked=true { spawn-sh "playerctl next"; }
        XF86MonBrightnessUp               allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown             allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }
    }
  '';
}
