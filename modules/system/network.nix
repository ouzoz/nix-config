{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  users.users.ouz.extraGroups = [ "networkmanager" ];
  networking.networkmanager = {
    enable = true;
    wifi = {
      backend = "iwd";
      scanRandMacAddress = true;
      powersave = false;
    };
  };

  networking.wireless.iwd.settings = {
    General = {
      AddressRandomization = "network";
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    dnsovertls = "true";
  };
}
