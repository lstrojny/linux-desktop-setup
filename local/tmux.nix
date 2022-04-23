{ settings, pkgs, ... }: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    historyLimit = settings.buffersize;
    terminal = "screen-256color";
    clock24 = true;

    # No escape delay, especially critical for vim
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [ yank ];

    extraConfig = ''
      set-window-option -g xterm-keys on

      bind-key -n M-t new-window

      bind-key -n M-left previous-window
      bind-key -n M-right next-window

      bind-key -n M-d split-window -h
      bind-key -n M-D split-window -v

      bind-key -n M-+ resize-pane -R

      set-option -g mouse on

      set-option -g automatic-rename on

      # Fix nvim colors
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # Status bar
      set-option -g status-position top

      # Activity and bell
      set-option -g activity-action any
      set-option -g bell-action any

      # Copy mode
      set-window-option -g mode-keys vi
      bind-key -n M-s copy-mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "copy"
      bind-key -T copy-mode-vi p send -X run "tmux set-buffer \"`xclip -o -selection clipboard`\"; tmux paste-buffer -d"
      bind-key -n M-p run "tmux set-buffer \"`paste`\"; tmux paste-buffer -d"
    '';
  };
}
