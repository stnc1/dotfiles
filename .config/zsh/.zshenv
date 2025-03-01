export HISTFILE="$ZDOTDIR/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000

export TERMINAL=/usr/bin/alacritty # for i3 default terminal
export GTK_THEME=Adwaita:dark      # default dark theme for gtk apps
export KEYTIMEOUT=1                # for quick vi mode switching
export EDITOR=/usr/bin/nvim        # default sudoedit
export PAGER=~/.local/bin/moar
export MOAR='-no-statusbar -quit-if-one-screen -wrap'

export FZF_DEFAULT_COMMAND='fd --type f --type d --strip-cwd-prefix --hidden --follow --exclude .wine'
export FZF_CTRL_T_COMMAND='fd --type f --type d --strip-cwd-prefix --hidden --follow --exclude .wine'

# wine
export WINEPREFIX="$HOME/.config/wine"
