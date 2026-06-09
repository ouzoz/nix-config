{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

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
    settings = {
      Resolve = {
        dnssec = "allow-downgrade";
        dnsovertls = "true";
      };
    };
  };
}
