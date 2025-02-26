{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      nv = "nv.sh";
      yazi = "yazi.sh";
      neo = "neo.sh";
      rmpc = "rmpc.sh";
      cava = "cava.sh";
      fastfetch = "clear; fastfetch";
      nvn = "cd /etc/nixos/; nv";
      switch = "sudo nixos-rebuild switch --flake /etc/nixos/.";
      update = "nix flake update --flake /etc/nixos/. --commit-lock-file";
      boot = "sudo nixos-rebuild boot --flake /etc/nixos/.";
      tmuxs = "tmux_start.sh";
      tdev = "tmux_dev.sh";
      cdn = "cd /etc/nixos/";
      tnix = "tmux_nix.sh";
    };
    antidote = {
      enable = true;
      plugins = [
        "chrissicool/zsh-256color"
      ];
    };
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source <(fzf --zsh)

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      export PATH="$PATH:$HOME/.local/share/bin"

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        kitty @ set-spacing padding=10
        yazi "$@" --cwd-file="$tmp"
        kitty @ set-spacing padding=default
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

    '';
  };
}
