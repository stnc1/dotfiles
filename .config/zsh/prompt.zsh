setopt PROMPT_SUBST

# color of arrow changes depending on vi mode
function update_prompt_mode() {
    if [[ $KEYMAP == vicmd ]]; then
        PROMPT='%F{magenta}[%n@%m]%f %F{green}%5~%f %F{cyan}>>%f '
    else
        PROMPT='%F{magenta}[%n@%m]%f %F{green}%5~%f %F{red}>>%f '
    fi
}

function zle-line-init() {
update_prompt_mode
zle reset-prompt
}

function zle-keymap-select() {
update_prompt_mode
zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Find and set branch name var if in git repository.
function git_branch_name()
{
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
    then
        :
    else
        echo '- ('$branch')'
    fi
}

RPROMPT='%F{yellow}%$(git_branch_name)'
