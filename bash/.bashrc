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



# ------ ENV ------
export PATH="~/.local/bin:$PATH"

export OPENCODE_ENABLE_EXA=1

