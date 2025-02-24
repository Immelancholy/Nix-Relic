{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    secureSocket = true;
    extraConfig = ''
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+

      unbind C-b
      set -g prefix C-s

      set -g mouse on
    '';
  };
}
