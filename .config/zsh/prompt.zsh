setopt PROMPT_SUBST

PROMPT='%F{magenta}[%n@%m]%f %F{green}%~%f %F{red}->%f '

# Функция для обновления цвета промпта в зависимости от режима
function update_prompt_mode() {
    if [[ $KEYMAP == vicmd ]]; then
        PROMPT='%F{magenta}[%n@%m]%f %F{green}%~%f %F{blue}->%f '
    else
        PROMPT='%F{magenta}[%n@%m]%f %F{green}%~%f %F{red}->%f '
    fi
}

# Хук для инициализации линии редактирования
function zle-line-init() {
update_prompt_mode
zle reset-prompt
}

# Хук для изменения режима
function zle-keymap-select() {
update_prompt_mode
zle reset-prompt
}

# Подключаем хуки
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
