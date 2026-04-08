{ config, pkgs, ... }:

{
  imports = [
    ../modules/programs/cli.nix
    ../modules/programs/development.nix

    ../modules/programs/foot.nix
  ];
}
