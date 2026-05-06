{ pkgs ? import <nixpkgs> {} }:

let
  libs = with pkgs; [
    stdenv.cc.cc.lib
  ];
in
pkgs.mkShell {
  packages = with pkgs; [
    pkg-config
  ];

  buildInputs = libs;

  env = {
    NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
  };

  shellHook = ''
    echo "> dev shell activated."
  '';
}
