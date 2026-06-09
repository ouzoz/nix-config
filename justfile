default: commit build

commit:
  git add -A
  git commit -m "$(date)"

build NAME="":
  sudo nixos-rebuild switch --flake .#{{NAME}}

specialization NAME:
  sudo nixos-rebuild switch --flake .# --specialisation {{NAME}}

update:
  nix flake update

gc:
  sudo nix-collect-garbage -d

gc-images:
  nix-collect-garbage -d --delete-older-than 2d

optimise:
  nix-store --optimise -v

update-rust:
  rm -rf ~/.rustup/toolchains/*
  rustup default stable

format:
  treefmt

format-check:
  treefmt --ci

size:
  nix run nixpkgs#nix-tree -- /run/current-system

key:
  ssh-keygen

niri-conf:
  niri validate

waybar-reload:
  systemctl --user restart waybar.service
