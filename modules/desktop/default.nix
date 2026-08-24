{ pkgs, ... }:

{
  imports = [
    ./emacs
    ./hyprland
    ./quickshell
    ./zen
    ./audio.nix
    ./clipboard.nix
    ./cursor.nix
    ./fonts.nix
    ./foot.nix
    ./fuzzel.nix
  ];

  security.pam.services.login.enableGnomeKeyring = true;

  services = {
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    # udisks2.enable = true;
    # blueman.enable = true;
  };

  programs = {
    thunar.enable = true;
  };

  # programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    # my.pkgs.helium
    # nautilus
    mpv

    hyprpicker
    # hyprpwcenter
    # hyprshutdown
    # hyprtoolkit
  ];
}
