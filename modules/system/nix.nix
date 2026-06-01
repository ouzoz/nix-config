{ inputs, ... }:

{
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 6d";
    };
  };

  environment.localBinInPath = true;

  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [];

  nixpkgs.config.allowUnfree = true;
}
