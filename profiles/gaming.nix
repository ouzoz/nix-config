{ config, pkgs, ... }:

{
  imports = [
    ../modules/programs/steam.nix
  ];
}
