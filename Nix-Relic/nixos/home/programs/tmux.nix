{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    secureSocket = true;
    terminal = "tmux-256color";
    mouse = true;
    disableConfirmationPrompt = true;
    prefix = "C-s";
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.tmux-nova;
        extraConfig = ''
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 

          set -g @nova-segment-whoami "#(whoami)@#h"

          set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right "whoami"
        '';
      }
    ];
    extraConfig = ''
      set -g default-command "/run/current-system/sw/bin/zsh"
      set -sa terminal-features ',xterm*:RGB'
      set -gq allow-passthrough on
      set -g update-environment 'KITTY_LISTEN_ON'

      bind-key r confirm-before -p "kill-session? (y/n)" kill-session
      bind-key d split-window -v
      bind-key r split-window -h
    '';
  };
}
