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
bindkey "^[[3~" delete-char                       # delete
bindkey "^[[H"  beginning-of-line                 # home
bindkey "^[[F"  end-of-line                       # end

# these can just be remapped in tmux too :shrug:
bindkey "^[[1~"  beginning-of-line                 # home (tmux)
bindkey "^[[4~"  end-of-line                       # end (tmux)

export PATH=/opt/homebrew/bin:$PATH

export EDITOR=nvim

PS1="[%*] %B%n%b@%F{4}%m%f:%F{2}%2~%f %# "

# force blinking block even after apps unset it
precmd() {
  echo -ne '\e[1 q'
}

alias ls="ls --color"
