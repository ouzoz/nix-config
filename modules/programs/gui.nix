{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    brave
    libreoffice
    # obsidian
    # thunderbird
  ];
}
