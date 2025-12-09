HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt ksh_arrays nomatch notify share_history
unsetopt autocd beep extendedglob
bindkey -e

zstyle :compinstall filename '/Users/nprice/.zshrc'
autoload -Uz compinit
compinit

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

export PATH=/opt/homebrew/bin:$PATH

export EDITOR=nvim

PS1="%n@%m %1~ %# "

alias ls="ls --color"
