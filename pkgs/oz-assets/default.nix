{ lib, runCommandLocal }:

let
  source = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.difference ./. ./default.nix;
  };
in
runCommandLocal "oz-assets" { } ''
  mkdir -p "$out/share"
  cp -r ${source}/. "$out/share/"
''
