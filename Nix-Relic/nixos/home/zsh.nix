{
  pkgs,
  inputs,
  ...
}: {
  home.file.".p10k.zsh" = {
    source = ./p10k.zsh;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -l";
      ls = "eza";
      edit = "sudo -e";
      rmpcs = "rmpc.sh";
      ca = "cava.sh";
      fastfetch = "clear; fastfetch";
      switch = ''cd $FLAKE_PATH; clear; fastfetch; git add .; git commit -m "switch"; sudo nixos-rebuild switch --flake .; git add . ; git commit -m "Update Flake Lock"; cd -'';
      update = "cd $FLAKE_PATH; clear; fastfetch; nix flake update --flake . --commit-lock-file; cd -";
      boot = ''cd $FLAKE_PATH; clear; fastfetch; git add .; git commit -m "switch"; sudo nixos-rebuild boot --flake .; git add . ; git commit -m "Update Flake Lock"; cd -'';
      nixp = "cd $FLAKE_PATH; git push -u origin main; cd -";
      firmware = "sudo systemctl reboot --firmware-setup";
    };
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
    plugins = [
      {
        name = "zsh-256color";
        src = inputs.zsh-256color;
      }
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
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source <(fzf --zsh)

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


      if [ "$class" = "fastfetch" ];
      then
        fastfetch --logo $HOME/Pictures/fastfetch_logos/Nakari.jpg
      else
        fortune | pokemonsay -p fennekin -N
      fi
    '';
  };
}
