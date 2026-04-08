{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/logitech.nix

    ../profiles/core.nix
    ../profiles/laptop.nix
  ];

  networking.hostName = "ouz";
  system.stateVersion = "25.11";
}
