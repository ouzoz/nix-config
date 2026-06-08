{ config, lib, ... }:

{
  system.stateVersion = "25.11";
  networking.hostName = "ouz";

  config.my.mod.desktop.external = true;

  specialisation.configuration.onthego = {
    system.nixos.tags = [ "onthego" ];
    config.my.desktop.external = lib.mkForce false;
  };
}
