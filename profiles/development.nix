{ config, pkgs, ... }:

{
  imports = [
    ../modules/programs/cli.nix
    ../modules/programs/foot.nix
  ];
}
