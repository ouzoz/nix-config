{ pkgs, ... }:

{
  environment.localBinInPath = true;

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
  };

  environment.systemPackages = with pkgs; [
    ripgrep
    fastfetch
    wget
    zip
    unzip
    unrar
    p7zip
    smartmontools
    openconnect
  ];
}
