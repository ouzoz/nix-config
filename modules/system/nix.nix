{ ... }:

{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 6d";
    };
  };

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
}
