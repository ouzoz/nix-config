{ pkgs, ... }:

{
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
    fastfetch

    wget
    smartmontools

    zip
    unzip
    unrar
    p7zip

    fd
    ripgrep
    just
  ];
}
