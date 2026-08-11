{ pkgs, ... }:

let
  formatter = pkgs.callPackage ./formatter.nix { };
  fs = pkgs.lib.fileset;
  src = fs.toSource {
    root = ./.;
    fileset = fs.difference ./. (fs.maybeMissing ./.git);
  };
in
{
  statix = pkgs.runCommand "statix-check" { nativeBuildInputs = [ pkgs.statix ]; } ''
    cd ${src}
    statix check .
    touch $out
  '';

  format = formatter.check src;
}
