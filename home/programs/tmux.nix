{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    secureSocket = true;
    mouse = true;
    prefix = "C-s";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
    ];
    extraConfig = ''
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+
    '';
  };
}
