# default
setopt autocd extendedglob nomatch notify
unsetopt beep

# enable vi mode
bindkey -v

# C-N and C-P up-down
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# auto-complete
source $ZDOTDIR/completion.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# prompt
source $ZDOTDIR/prompt.zsh
# aliases
source $ZDOTDIR/aliases.zsh

# zoxide
eval "$(zoxide init --cmd cd zsh)"
# fzf
source <(fzf --zsh)

## for i3 tab title
# updating term title
function set_window_title {
  local cmd=${1%% *} # get first part of cmd, like "nvim"
  echo -ne "\033]0;$cmd\007" # set title
}
# this executes before each command
preexec() {
  set_window_title "$1"
}
# Устанавливаем дефолтный заголовок на имя терминала (например, zsh), если ничего не выполняется
precmd() {
  echo -ne "\033]0;zsh\007"
}
