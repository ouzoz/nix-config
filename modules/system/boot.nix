{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;

      configurationLimit = 12;
      timeoutStyle = "menu";

      extraConfig = ''
        set gfxmode=auto
        set gfxpayload=keep
      '';

      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }

        menuentry "Poweroff" {
          halt
        }
      '';

      splashImage = ./background.png;
      theme = pkgs.writeTextDir "theme.txt" ''
        desktop-color: "#000000"

        title-text: ""
        message-font: "Unifont Regular 16"
        message-color: "#ffffff"

        terminal-font: "Unifont Regular 16"

        + boot_menu {
          left = 25%
          top = 30%
          width = 50%
          height = 45%

          item_font = "Unifont Regular 16"
          item_color = "#bbbbbb"
          selected_item_color = "#ffffff"

          icon_width = 0
          icon_height = 0

          item_height = 32
          item_padding = 8
          item_spacing = 4
        }

        + label {
          top = 82%
          left = 0
          width = 100%
          align = "center"
          text = "NixOS"
          font = "Unifont Regular 16"
          color = "#ffffff"
        }
      '';
    };
  };
}
