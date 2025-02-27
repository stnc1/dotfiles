# default
setopt autocd extendedglob nomatch notify
unsetopt beep

# vi mode
bindkey -v
bindkey '^?' backward-delete-char

# prompt
source $ZDOTDIR/prompt.zsh

# Auto-complete
source $ZDOTDIR/completion.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^F' forward-char # for applying suggestion

# Aliases
source $ZDOTDIR/aliases.zsh

# Fish-like syntax
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# text objects like in vim
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# For custom OW color
eval $(dircolors /etc/DIR_COLORS)

# fzf
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# zoxide
eval "$(zoxide init --cmd cd zsh)"

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
