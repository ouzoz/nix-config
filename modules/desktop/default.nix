{ pkgs, my, ... }:

{
  imports = my.lib.modules.paths ./.;

  # services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    # my.pkgs.helium
    nautilus
    hyprpicker
  ];
}
