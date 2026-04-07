{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    # loginShellInit = builtins.readFile ./.bashrc;
    # interactiveShellInit = builtins.readFile ./.bashrc;
    interactiveShellInit = ''
      # History configuration [cite: 6]
      export HISTSIZE=6000
      export HISTFILESIZE=6000
      export HISTIGNORE='l:exit:clear:history'
      export HISTCONTROL='ignoreboth:erasedups'
      shopt -s histappend
      shopt -s cmdhist

      # Custom prompt colors [cite: 5]
      PS1='\[\033[36m\]\w\[\033[31m\] \$ \[\033[00m\]'
      PS2='\[\033[31m\]> \[\033[00m\]'
    '';
    promptInit = "";
    shellAliases = {
      # shortcuts
      l = "ls -ACxX --group-directories-first --color=auto";
      # loc
      tok = "tokei -C -s lines -n dots";
      tokf = "tok -f";
      lan = "github-linguist";
      # nix
      conf-dir = "cd /etc/nixos";
      conf-edit = "vi /etc/nixos/configuration.nix";
      conf-build = "sudo nixos-rebuild switch --flake /etc/nixos#ouz";
      conf-update = "sudo nix flake update";
      conf-gc = "sudo nix-collect-garbage -d";
      conf-direnv = "echo 'use flake' > .envrc && direnv allow";
      conf-flake = "nix develop";
      conf-template = "nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-flake-templates && direnv allow";
      conf-search = "nix search nixpkgs";
      # git
      gs = "git status";
      gc = "git commit -m";
      ga = "git add";
      gp = "git push";
      gpu = "git pull";
      gd = "git diff";
      gl = "git log --oneline -12";
      gi = "gd --stat";
      # alias gr = "git reset HEAD"
      # alias m = "git checkout master"
      # alias gch = "git checkout"
      # alias gm = "git merge"
      # commands
      oz-token = "openssl rand -hex 16";
      oz-ram = "top -b -o +RES -n 1 -Em -em | head -n 60";
      oz-app-start = "systemctl list-unit-files --type=service | grep enabled";
    };
  };
}
