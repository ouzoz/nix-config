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

  environment = {
    shellAliases = {
      j = "just";
    };

    systemPackages = with pkgs; [
      libarchive
      wget
      fd
      ripgrep
      just
    ];
  };
}
