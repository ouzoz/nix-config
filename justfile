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

hash HASH:
  nix hash convert --to sri --hash-algo sha256 {{HASH}}

hash-url URL:
  nix store prefetch-file --hash-type sha256 {{URL}}

niri-conf:
  niri validate

waybar-reload:
  systemctl --user restart waybar.service

wifir:
  nmcli r wifi off
  nmcli r wifi on
  nmcli d wifi rescan
  nmcli d wifi list
