alias ls="ls --color"

export SYSTEMD_PAGER=
export HISTSIZE=1000000
export HISTFILESIZE=1000000000

export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1

shopt -s globstar
shopt -s histappend

#git branch | grep \* | awk '{print $2}'

PROMPT_COMMAND="history -a;__prompt_command" # Func to gen PS1 after CMDs
__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""
    local RCol='\[\e[0m\]'
    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local Yel='\[\e[0;33m\]'
    local BYel='\[\e[1;33m\]'
    local Blu='\[\e[0;34m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    PS1+="${Gre}\u${RCol}@${Blu}\h "
    if [ $EXIT != 0 ]; then
        PS1+="${Red}(r:$EXIT)${RCol} "      # Add red if exit code non 0
    else
        PS1+="${Gre}(r:$EXIT)${RCol} "      # Add red if exit code non 0
    fi
    PS1+="${Yel}\W${RCol} $ "
}


PATH=$PATH:/home/nprice/Apps/010editor;export PATH; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - 87FF8EFC-483D-BCAA-D67D-735CF60410D1 0B3F8723-AB0D-0D6D-22E2-E9E518F227EF
