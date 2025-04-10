{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    secureSocket = true;
    mouse = true;
    disableConfirmationPrompt = true;
    prefix = "C-s";
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = ''
          set -agF status-right "#{E:@catppuccin_status_cpu}"
        '';
      }
    ];
    extraConfig = ''
      set -g default-command "/run/current-system/sw/bin/zsh"
      set -gq allow-passthrough on
      set -g update-environment 'KITTY_LISTEN_ON'

      bind-key r confirm-before -p "kill-session? (y/n)" kill-session
    '';
  };
}
