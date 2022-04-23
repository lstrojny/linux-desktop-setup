{ settings, ... }: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    historyLimit = settings.buffersize;
    terminal = "screen-256color";

    extraConfig = ''
      set-window-option -g xterm-keys on

      bind -n M-t new-window

      bind -n M-left previous-window
      bind -n M-right next-window

      bind -n M-d split-window -h
      bind -n M-D split-window -v

      bind -n M-+ resize-pane -R

      set-option -g mouse on

      set-option -g automatic-rename on

      # Fix nvim colors
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # Status bar
      set-option -g status-position top

      # Activity and bell
      set-option -g activity-action any
      set-option -g bell-action any

      # No escape delay, especially critical for vim
      set-option -sg escape-time 0
    '';
  };
}
