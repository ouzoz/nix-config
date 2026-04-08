{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    interactiveShellInit = ''
      shopt -s histappend
      shopt -s cmdhist
    '';
    promptInit = ''
      PS1='\[\033[36m\]\w\[\033[31m\] \$ \[\033[00m\]'
      PS2='\[\033[31m\]> \[\033[00m\]'
    '';
    shellAliases = {
      l = "ls -ACxX --group-directories-first --color=auto";
      oz-token = "openssl rand -hex 16";
      oz-ram = "top -b -o +RES -n 1 -Em -em | head -n 60";
    };
  };
  environment.sessionVariables = {
    HISTSIZE = 6000;
    HISTFILESIZE = 6000;
    HISTIGNORE = "l:exit:clear:history";
    HISTCONTROL = "ignoreboth:erasedups";
  };
}
