{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 6d";
  };

  environment.shellAliases = {
    # nixos configs
    ozc-ouz = "sudo nixos-rebuild switch --flake /etc/nixos#ouz";

    # helpers
    ozc-dir = "cd /etc/nixos";
    ozc-update = "nix flake update";
    ozc-gc = "sudo nix-collect-garbage -d";
    ozc-search = "nix search nixpkgs";

    # flakes
    ozc-flake = "nix develop";

    ozc-tem = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#empty";
  };
}
