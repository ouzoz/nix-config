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
  niri = pkgs.runCommand "niri-config-check" { nativeBuildInputs = [ pkgs.niri ]; } ''
    niri validate --config ${./modules/desktop/niri/config.kdl}
    touch $out
  '';

  statix = pkgs.runCommand "statix-check" { nativeBuildInputs = [ pkgs.statix ]; } ''
    cd ${src}
    statix check .
    touch $out
  '';

  format = formatter.check src;
}
