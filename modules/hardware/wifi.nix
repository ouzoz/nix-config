_:

{
  networking.networkmanager.wifi = {
    backend = "iwd";
    scanRandMacAddress = true;
    powersave = false;
  };

  networking.wireless.iwd.settings = {
    General = {
      AddressRandomization = "network";
    };
  };
}
