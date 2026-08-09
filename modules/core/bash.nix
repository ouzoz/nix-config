_:

{
  environment.shellAliases = {
    l = "LC_COLLATE=C ls -ACx --group-directories-first --color=auto";
    # l = "ls -ACxX --group-directories-first --color=auto"; # -F (symbols)
    nd = "exec nix develop";
    nf = "nix flake";
  };

  environment.variables = {
    HISTSIZE = 6000;
    HISTFILESIZE = 6000;
    HISTIGNORE = "l:exit:clear:history";
    HISTCONTROL = "ignoreboth:erasedups";
  };

  programs.bash = {
    enable = true;
    shellInit = ''
      shopt -s histappend
      shopt -s cmdhist
    '';
    promptInit = ''
      PS1='\[\033[36m\]\w\[\033[31m\] \$ \[\033[00m\]'
      PS2='\[\033[31m\]> \[\033[00m\]'
    '';
  };
}
