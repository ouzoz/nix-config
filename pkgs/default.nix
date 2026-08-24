{ pkgs }:

(import ../lib.nix { inherit (pkgs) lib; }).paths ./. (path: pkgs.callPackage path { })
