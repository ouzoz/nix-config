default: build

search:
  nix search nixpkgs

build:
  sudo nixos-rebuild switch --flake /etc/nixos#

update:
  nix flake update

gc:
  sudo nix-collect-garbage -d
