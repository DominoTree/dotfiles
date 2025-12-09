# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt nomatch notify ksh_arrays
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/nprice/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

export PATH=/opt/homebrew/bin:$PATH

PS1="%n@%m %1~ %# "

# eval "$(starship init zsh)"
