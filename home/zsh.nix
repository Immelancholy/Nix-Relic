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
      neo = "neo.sh";
      rmpcs = "rmpc.sh";
      cava = "cava.sh";
      fastfetch = "clear; fastfetch";
      nvn = "cd /etc/nixos/; nv";
      switch = ''cd /etc/nixos/; clear; fastfetch; git add .; git commit -m "switch"; sudo nixos-rebuild switch --flake /etc/nixos/. ; git add . ; git commit -m "Update Flake Lock"; cd -'';
      update = "cd /etc/nixos/; clear; fastfetch; nix flake update --flake /etc/nixos/. --commit-lock-file; cd -";
      boot = ''cd /etc/nixos/; clear; fastfetch; git add .; git commit -m "switch"; sudo nixos-rebuild boot --flake /etc/nixos/. ; git add . ; git commit -m "Update Flake Lock"; cd -'';
      tmuxs = "tmux_start.sh";
      tdev = "tmux_dev.sh";
      cdn = "cd /etc/nixos/";
      tnix = "tmux_nix.sh";
      nixp = "cd /etc/nixos; git push -u origin main; cd -";
      firmware = "sudo systemctl reboot --firmware-setup";
      tnotes = "tmux_notes.sh";
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
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ];
    profileExtra = ''
      eval $(gnome-keyring-daemon --start --daemonize)
    '';
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source <(fzf --zsh)

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      export PATH="$PATH:$HOME/.local/share/bin"
      poke.sh

    '';
  };
}
