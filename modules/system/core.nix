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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    settings.global.log_format = "-";
  };
}
