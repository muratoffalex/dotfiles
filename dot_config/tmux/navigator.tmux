# NOTE: Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'M-n' if-shell "$is_vim" 'send-keys M-n'  'select-pane -L'
bind-key -n 'M-e' if-shell "$is_vim" 'send-keys M-e'  'select-pane -D'
bind-key -n 'M-i' if-shell "$is_vim" 'send-keys M-i'  'select-pane -U'
bind-key -n 'M-o' if-shell "$is_vim" 'send-keys M-o'  'select-pane -R'
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'M-\\' if-shell \"$is_vim\" 'send-keys M-\\\\'  'select-pane -l'"

bind-key -T copy-mode-vi 'M-n' select-pane -L
bind-key -T copy-mode-vi 'M-e' select-pane -D
bind-key -T copy-mode-vi 'M-i' select-pane -U
bind-key -T copy-mode-vi 'M-o' select-pane -R
bind-key -T copy-mode-vi 'M-\' select-pane -l
