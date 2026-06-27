_:

{
  system.stateVersion = "25.11";
  networking.hostName = "ouz";

  my = {
    mod = {
      applications = {
        obs.enable = false;
      };
    };
  };

  #
  # specialisation.configuration.onthego = {
  #   system.nixos.tags = [ "onthego" ];
  #   config.my.desktop.external = lib.mkForce false;
  # };
}
