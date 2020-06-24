# Open a new terminal (rxvt) window in a detached tmux session so it remains open
cmd="urxvt -cd $PWD"
tmux new-session -d
tmux send-keys "$cmd" C-m
tmux dettach
# Close active window
xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter
