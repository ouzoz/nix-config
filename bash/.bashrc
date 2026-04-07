if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip -color=auto'
fi

PS1='\[\033[36m\]\w\[\033[31m\] \$ \[\033[00m\]'
PS2='\[\033[31m\]> \[\033[00m\]'

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

export HISTSIZE=6000
export HISTFILESIZE=6000
export HISTIGNORE='l:exit:clear:history'
export HISTCONTROL='ignoreboth:erasedups'
shopt -s histappend
shopt -s cmdhist


# shortcuts
alias l='ls -ACxX --group-directories-first'

# loc
alias tok='tokei -C -s lines -n dots'
alias tokf='tok -f'
alias lan='github-linguist'

# nix
alias conf-dir='cd /etc/nixos'
alias conf-edit='vi /etc/nixos/configuration.nix'
alias conf-build='sudo nixos-rebuild switch --flake /etc/nixos#ouz'
alias conf-update='sudo nix flake update'
alias conf-gc='sudo nix-collect-garbage -d'
alias conf-direnv='echo "use flake" > .envrc && direnv allow'
alias conf-flake='nix develop'
alias conf-template='nix flake init -t git+ssh://git@github.com/oguzhanozkaya/nix-flake-templates && direnv allow'
alias conf-search='nix search nixpkgs'

# git
alias gs='git status'
alias gc='git commit -m'
alias ga='git add'
alias gp='git push'
alias gpu='git pull'
alias gd='git diff'
alias gl='git log --oneline -12'
alias gi='gd --stat'
# alias gr='git reset HEAD'
# alias m='git checkout master'
# alias gch='git checkout'
# alias gm='git merge'

# commands
alias oz-token='openssl rand -hex 16'
alias oz-ram='top -b -o +RES -n 1 -Em -em | head -n 60'
alias oz-app-start='systemctl list-unit-files --type=service | grep enabled'

# ------ ENV ------
export PATH="~/.local/bin:$PATH"

#cargo
export PATH=~/.cargo/bin:$PATH

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

# Android Studio Java (JBR)
export JAVA_HOME=/opt/android-studio/jbr
export PATH=$JAVA_HOME/bin:$PATH

# Maestro CLI
export PATH="$PATH:$HOME/.maestro/bin"

export OPENCODE_ENABLE_EXA=1

export PATH="/home/oguzhanozkaya/.local/share/gem/ruby/3.4.0/bin:$PATH"
export PATH="/opt/cuda/bin:$PATH"
