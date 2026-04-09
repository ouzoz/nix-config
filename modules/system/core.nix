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
  settings = {
    global = {
      hide_env_diff = true;
      warn_timeout = "5m";
      log_format = "";
    };
  };
}
