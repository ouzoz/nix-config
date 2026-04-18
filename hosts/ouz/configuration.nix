{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/logitech.nix
    ../../modules/hardware/swap.nix

    ../../profiles/core.nix
    ../../profiles/laptop.nix
    ../../profiles/development.nix
  ];

  networking.hostName = "ouz";
  system.stateVersion = "25.11";
}
