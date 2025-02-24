{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    secureSocket = true;
    mouse = true;
    disableConfirmationPrompt = true;
    prefix = "C-s";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      tmuxPlugins.battery
      tmuxPlugins.cpu
      # {
      #   plugin = tmuxPlugins.catppuccin;
      #   extraConfig = ''
      #     set -g @catppuccin_flavor "mocha"
      #     set -g @catppuccin_window_status_style "rounded"
      #     set -g status-right-length 100
      #     set -g status-left-length 100
      #     set -g status-left ""
      #     set -g status-right "#{E:@catppuccin_status_application}"
      #     set -agF status-right "#{E:@catppuccin_status_cpu}"
      #     set -ag status-right "#{E:@catppuccin_status_session}"
      #     set -ag status-right "#{E:@catppuccin_status_uptime}"
      #     set -agF status-right "#{E:@catppuccin_status_battery}"
      #   '';
      # }
    ];
  };
}
