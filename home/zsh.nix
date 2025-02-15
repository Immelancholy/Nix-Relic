{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nixos-rebuild switch --upgrade";
      nv = "/home/mela/.local/share/bin/kitty_nvim.sh";
      yazi = "/home/mela/.local/share/bin/yazi.sh";
      neo = "/home/mela/.local/share/bin/neo.sh";
      rmpc = "/home/mela/.local/share/bin/rmpc.sh";
      cava = "$HOME/.local/share/bin/cava.sh";
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
    zplug = {
      enable = true;
      plugins = [
        {name = "chrissicool/zsh-256color";}
      ];
    };
    initExtra = ''
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

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      fortune | pokemonsay -p fennekin -N
    '';
  };
}
