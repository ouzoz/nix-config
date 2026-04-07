{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    loginShellInit = builtins.readFile ./.bashrc;
    interactiveShellInit = builtins.readFile ./.bashrc;
    promptInit = "";
  };
}
