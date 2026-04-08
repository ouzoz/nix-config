{ config, pkgs, ... }:

{
  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    just
    ripgrep
    wget

    zip
    unzip
    smartmontools
    openconnect
  ];
}
