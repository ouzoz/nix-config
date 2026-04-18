default: build

search:
  nix search nixpkgs

build:
  nixos-rebuild switch --flake /etc/nixos#

update:
  nix flake update

gc:
  nix-collect-garbage -d
