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

alias srczsh='source ~/.config/zsh/.zshrc'

alias nv='nvim'
