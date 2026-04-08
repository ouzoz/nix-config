{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    secureSocket = true;
    keyMode = "vi";
    historyLimit = 6000;
    escapeTime = 0;
    clock24 = true;
    baseIndex = 1;
    aggressiveResize = true;

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
