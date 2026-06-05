{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/hardware.nix

    ../../profiles/applications.nix
    ../../modules/desktop

    ../../profiles/development.nix

    ../../profiles/core.nix
    ../../profiles/system.nix
  ];

  networking.hostName = "ouz";
  system.stateVersion = "25.11";
}
