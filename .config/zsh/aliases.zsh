# для запуска плеера с настройками 1 - серия с которой начинать 2 - дорожка аудио, 3 - задержка сабов
cell() {
    local audio=${2:-1}
    local sub_delay=${3:-0}
    celluloid --mpv-sub-auto=fuzzy --mpv-aid="$audio" --mpv-sub-delay="$sub_delay" --mpv-playlist-start="$1" .
}

alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'

alias c='clear'
alias ls='ls --color=auto --human-readable'
alias ll='ls -la --color=auto --human-readable'
alias l='ls -l --color=auto --human-readable'

alias g='git'
# alias gs='git status -s'
# alias gst='git status'
# 
# alias ga='git add'
# alias gci='git commit'
# 
# alias gb='git branch'
# alias gsw='git switch'
# alias gch='git checkout'
# 
# alias gf='git fetch'
# alias gmg='git merge'
# alias grb='git rebase'
# 
# alias gpl='git pull --rebase'
# alias gps='git push'
# 
# alias gd='git diff'
# alias gds='git diff --staged'
# 
# alias gl='git log --graph --abbrev-commit --decorate --format=format:"%C(bold yellow)%h%C(reset) - %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n""          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n"'

alias srzsh='source ~/.config/zsh/.zshrc'

alias nv='nvim'
