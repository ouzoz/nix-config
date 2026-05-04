{ pkgs, ... }:

{
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    glib
  ];

  environment.systemPackages = with pkgs; [
    just
    uv
    rustup
    bun
  ];
}
