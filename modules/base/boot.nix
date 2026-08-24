{ pkgs, config, ... }:

let
  theme = config.ozozka.theme;
in
{
  imports = [ ../theme.nix ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;
    # systemd-boot = {
    #   enable = true;
    #   editor = false;
    # };
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

      splashImage = theme.wallpaper;
      theme = pkgs.writeTextDir "theme.txt" ''
        desktop-color: "${theme.colors.tokens.b}"

        title-text: "naber"
        message-font: "Unifont Regular 16"
        message-color: "${theme.colors.tokens.f}"

        terminal-font: "Unifont Regular 16"

        + boot_menu {
          left = 25%
          top = 30%
          width = 50%
          height = 45%

          item_font = "Unifont Regular 16"
          item_color = "${theme.colors.tokens.m}"
          selected_item_color = "${theme.colors.tokens.f}"

          icon_width = 0
          icon_height = 0

          item_height = 32
          item_padding = 12
          item_spacing = 6
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
