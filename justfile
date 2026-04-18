default: commit build

search:
  nix search nixpkgs

commit:
  git add -A
  git commit -m "$(date)"

build:
  sudo nixos-rebuild switch --flake /etc/nixos#

update:
  nix flake update

gc:
  sudo nix-collect-garbage -d
