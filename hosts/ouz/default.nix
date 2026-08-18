_:

{
  imports = [ ./hardware-configuration.nix ];
  system.stateVersion = "25.11";
  networking.hostName = "ouz";

  my = {
    misc = {
      chatgpt.enable = false;

      obs.enable = false;

      steam.enable = true;

      gimp.enable = true;
      office.enable = true;

      lan-stats.enable = true;
      lsp.enable = true;
    };
  };

  specialisation = {
    # Uses integrated gpu and laptop monitor
    mobile = {
      inheritParentConfig = true;
      configuration = {
        system.nixos.tags = [ "mobile" ];

        # my.desktop.external = lib.mkForce false;
      };
    };
  };

  users.users.ouz = {
    isNormalUser = true;
    description = "ouz";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  my.home.users = {
    ouz = {
      emacs = true;
    };
  };
}
