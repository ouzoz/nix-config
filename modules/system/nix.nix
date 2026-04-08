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
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.shellAliases = {
    conf-dir = "cd /etc/nixos";
    conf-edit = "vi /etc/nixos/configuration.nix";
    conf-build = "sudo nixos-rebuild switch --flake /etc/nixos#ouz";
    conf-update = "sudo nix flake update";
    conf-gc = "sudo nix-collect-garbage -d";
    conf-direnv = "echo 'use flake' > .envrc && direnv allow";
    conf-flake = "nix develop";
    conf-template = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-flake-templates && direnv allow";
    conf-search = "nix search nixpkgs";
  };
}
