alpha='dd'
background='#282a36'
selection='#44475a'
comment='#6272a4'
yellow='#f1fa8c'
orange='#ffb86c'
red='#ff5555'
magenta='#ff79c6'
blue='#6272a4'
cyan='#8be9fd'
green='50fa7b'

i3lock -e \
  --insidever-color=$selection$alpha      \
  --insidewrong-color=$selection$alpha    \
  --inside-color=$selection$alpha         \
  \
  --ringver-color=$green$alpha            \
  --ringwrong-color=$red$alpha            \
  --ringver-color=$green$alpha            \
  --ringwrong-color=$red$alpha            \
  --ring-color=$blue$alpha                \
  \
  --line-uses-ring                        \
  --keyhl-color=$magenta$alpha            \
  --bshl-color=$orange$alpha              \
  --separator-color=$selection$alpha      \
  --verif-color=$green                    \
  --wrong-color=$red                      \
  --modif-color=$red                      \
  --layout-color=$blue                    \
  --date-color=$blue                      \
  --time-color=$blue                      \
  \
  --screen 1                              \
  --blur 1                                \
  \
  --verif-text="..."                      \
  --wrong-text="denied"                   \
  --noinput="no input"                    \
  --lock-text="locking..."                \
  --lockfailed="lock Failed"              \
  --radius=120                            \
  --ring-width=10                         \
  \
  --clock                                 \
  --indicator                             \
  --time-str="%H:%M:%S"                   \
  --date-str="%A %e %B %Y"                \
  --keylayout 1                           \
  \
  --pass-media-keys                       \
  --pass-screen-keys                      \
  --pass-volume-keys                      \
  \
  --time-font="JetBrainsMono Nerd Font"   \
  --date-font="JetBrainsMono Nerd Font"   \
  --layout-font="JetBrainsMono Nerd Font" \
  --verif-font="JetBrainsMono Nerd Font"  \
  --wrong-font="JetBrainsMono Nerd Font"  \
& sleep 60                                \

# turn off monitors if not unlocked before timer
if pgrep -x 'i3lock' > /dev/null; then
	systemctl suspend
fi
