{ config, pkgs, ... }:

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

  nixpkgs.config.allowUnfree = true;

  environment.shellAliases = {
    # helpers
    ozc = "sudo nixos-rebuild switch --flake /etc/nixos#";
    ozc-dir = "cd /etc/nixos";
    ozc-gc = "sudo nix-collect-garbage -d";
    ozc-search = "nix search nixpkgs";
    ozc-update = "nix flake update";
    ozc-shell = "nix-shell";

    # dev shell templates
    ozc-tem = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#empty";
    ozc-tem-tex = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#tex";
    ozc-tem-python = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#python";
    ozc-tem-typescript = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#typescript";
    ozc-tem-rust = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#rust";
    ozc-tem-cpp = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-config#cpp";
  };
}
