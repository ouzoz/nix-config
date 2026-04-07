{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    loginShellInit = builtins.readFile ./.bash_profile;
    interactiveShellInit = builtins.readFile ./.bashrc;
  };
}
