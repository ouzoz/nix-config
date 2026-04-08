{ config, pkgs, ... }:

{
  users.users.ouz = {
    isNormalUser = true;
    description = "ouz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
