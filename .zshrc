HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

setopt ksh_arrays 
setopt nomatch 
setopt notify 

setopt share_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

unsetopt autocd
unsetopt beep 
unsetopt extendedglob

bindkey -e

zstyle :compinstall filename '/Users/nprice/.zshrc'
autoload -Uz compinit
compinit

bindkey "^[[A"  history-beginning-search-backward # up
bindkey "^[[B"  history-beginning-search-forward  # down
bindkey "^[[H"  beginning-of-line                 # home
bindkey "^[[F"  end-of-line                       # end
bindkey "^[[3~" delete-char                       # delete

export PATH=/opt/homebrew/bin:$PATH

export EDITOR=nvim

PS1="%n@%m %1~ %# "

alias ls="ls --color"

cd
