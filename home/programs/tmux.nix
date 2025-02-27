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
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = ''
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -gq allow-passthrough on
          set -g update-environment 'KITTY_LISTEN_ON'

          bind-key k confirm-before -p "kill-session? (y/n)" kill-session
          bind-key r update-environment 'KITTY_LISTEN_ON'
        '';
      }
    ];
  };
}
