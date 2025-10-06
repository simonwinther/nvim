# 💤 LazyVim

# For my terminal I use wezterm with some stuff from this video added:
https://www.youtube.com/watch?v=TTgQV21X0SQ&t=470s

fork also here: https://github.com/simonwinther/dev-environment-files


## 1. Clone TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## 2. Download josean-dev's tmux config
curl https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/.tmux.conf --output ~/.tmux.conf

## TMux keybinds:
- `ctrl +a + |` (vertical split)
- `ctrl + a + -` (horizontal), 
- `ctrl +  h, j, k, l` vim motions to move around,
- `ctrl + a + c` - new window, 
- `ctrl + a + s` (tmux sessions)

Other the `.tmux.conf` is down below if he put it down:

```
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

unbind %
bind | split-window -h 

unbind '"'
bind - split-window -v

unbind r
bind r source-file ~/.tmux.conf

bind j resize-pane -D 5
bind k resize-pane -U 5
bind l resize-pane -R 5
bind h resize-pane -L 5

bind -r m resize-pane -Z

bind M-c attach-session -c "#{pane_current_path}"

set -g mouse on

set-window-option -g mode-keys vi

bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse

# remove delay for exiting insert mode with ESC in Neovim
set -sg escape-time 10

# tpm plugin
set -g @plugin 'tmux-plugins/tpm'

# list of tmux plugins
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes
set -g @plugin 'fabioluciano/tmux-tokyo-night'


set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```
