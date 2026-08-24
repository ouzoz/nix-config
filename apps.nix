{ pkgs, ... }:

rec {
  default = info;

  info = {
    type = "app";
    meta.description = "Run fastfetch with custom modules.";
    program =
      let
        lockLastModified = toString (builtins.fromJSON (builtins.readFile ./flake.lock))
          .nodes.nixpkgs.locked.lastModified;
        script = pkgs.writeShellApplication {
          name = "info";

          runtimeInputs = with pkgs; [
            fastfetch
            nix
            coreutils
            gawk
          ];

          text = ''
            lock_age_seconds=$(( $(date +%s) - ${lockLastModified} ))
            lock_age_days=$(( lock_age_seconds / 86400 ))
            lock_age_hours=$(( lock_age_seconds % 86400 / 3600 ))
            if (( lock_age_days > 0 )); then
              lock_age="''${lock_age_days}d ''${lock_age_hours}h"
            else
              lock_age="''${lock_age_hours}h"
            fi

            generation=$(readlink /nix/var/nix/profiles/system)
            generation="''${generation#system-}"
            generation="''${generation%-link}"

            shopt -s nullglob
            generations=(/nix/var/nix/profiles/system-*-link)
            retained_generations="''${#generations[@]}"

            count=$(nix-store -qR /run/current-system | wc -l)
            size=$(nix path-info -Sh /run/current-system | awk '{print $2}')

            cat <<EOF | fastfetch -c -
            {
              "logo": {
                "position": "top"
              },
              "modules": [
                "version",
                "title",

                "break",
                {"type": "custom", "format": "{#1}Status{#}", "outputColor": "red"},
                "uptime",
                "player",
                "sound",
                "bluetoothradio",
                "bluetooth",
                {"type": "publicip", "timeout": 1000},
                {"type": "localip", "showIpv6": true, "showMac": true, "showSpeed": true, "showMtu": true, "showLoop": true, "showFlags": true, "showAllIps": true},
                "dns",
                "wifi",
                {"type": "codec", "splitGPU": true},
                "physicalmemory",
                "vulkan",
                "opengl",
                "opencl",
                {"type": "swap", "separate": true},
                "disk",
                {"type": "battery", "temp": true},

                "break",
                {"type": "custom", "format": "{#1}Hardware{#}", "outputColor": "red"},
                "camera",
                "gamepad",
                "mouse",
                "keyboard",
                "monitor",
                {"type": "gpu", "driverSpecific": true},
                "cpucache",
                {"type": "cpu", "showPeCoreCount": true},
                "memory",
                "poweradapter",
                "physicaldisk",
                
                "break",
                {"type": "custom", "format": "{#1}Desktop{#}", "outputColor": "red"},
                "cursor",
                "wallpaper",
                "font",
                "icons",
                "theme",
                "wmtheme",
                "wm",
                "de",
                "lm",
                "brightness",
                "display",
                {"type": "colors", "symbol": "block", "block": {"width": 3}},

                "break",
                {"type": "custom", "format": "{#1}Environment{#}", "outputColor": "red"},
                "terminalfont",
                "terminaltheme",
                "terminalsize",
                "editor",
                "locale",
                "shell",
                "terminal",
                "users",
                
                "break",
                { "type": "custom", "format": "{#1}System{#}", "outputColor": "red" },
                "tpm",
                "initsystem",
                "os",
                "kernel",
                "bootmgr",
                "bios",
                "board",
                "host",
                "chassis",
                
                "break",
                {"type": "custom", "format": "{#1}Packages{#}", "outputColor": "red"},
                {"type": "custom", "key": "Lock Age", "format": "$lock_age"},
                {"type": "custom", "key": "Retained Generations", "format": "$retained_generations"},
                {"type": "custom", "key": "Generation", "format": "$generation"},
                "packages",
                {"type": "custom", "key": "Paths", "format": "$count"},
                {"type": "custom", "key": "Store Size", "format": "$size GiB"}
              ]
            }
            EOF
          '';
        };
      in
      "${script}/bin/info";
  };
}
