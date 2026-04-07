{ config, pkgs, ... }:
{
  programs.bash = {
    loginShellInit = builtins.readFile ./.bash_profile;
    interactiveShellInit = builtins.readFile ./.bashrc;
  };
}
