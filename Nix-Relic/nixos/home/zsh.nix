{
  pkgs,
  inputs,
  ...
}: {
  # home.file.".p10k.zsh" = {
  #   source = ./p10k.zsh;
  # };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -l";
      ls = "eza";
      edit = "sudo -e";
      ca = "cava.sh";
      firmware = "sudo systemctl reboot --firmware-setup";
      gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
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
      # {
      #   name = "powerlevel10k";
      #   src = pkgs.zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ];
    initContent =
      /*
      bash
      */
      ''
        bindkey -e

        last_repo=
        INIT=1
        onefetch_img () {
          image="$(find ~/Pictures/fastfetch_logos/ -name "*.jpg" -o -name "*.png" 2> /dev/null | shuf -n1)"
          if [ "$image" ]; then
            onefetch --image-protocol kitty -i "$image"
          else
            onefetch
          fi
        }
        tmux_fetch () {
          image=$(find $HOME/Pictures/fastfetch_logos/ -name "*.jpg" -o -name "*.png" | shuf -n 1)
          chafa --passthrough tmux -f kitty "$image" --align left -s 23x18 | fastfetch --raw -
        }

        check_tmux () {
          if [ -z $TMUX ]; then
            fetch_cmd=onefetch_img
            alias fastfetch="fastfetch"
          else
            fetch_cmd=tmux_fetch
            alias fastfetch="tmux_fetch"
          fi
        }
        check_tmux
        check_for_repo () {
          current_repo=$(git rev-parse --show-toplevel 2> /dev/null)
          if [ "$current_repo" ] && \
            [ "$current_repo" != "$last_repo" ]; then
            clear
            $fetch_cmd
            last_repo=$current_repo
            INIT=0
            GIT=1
          elif [ $INIT = 1 ]; then
            fortune | pokemonsay -p fennekin -N
            GIT=0
            INIT=0
          elif [ ! "$current_repo" ] && \
            [ $GIT = 1 ]; then
            clear
            fortune | pokemonsay -p fennekin -N
            GIT=0
            last_repo=
          fi
        }

        z () {
          __zoxide_z "$@"
          check_for_repo
        }

        zi () {
          __zoxide_zi "$@"
          check_for_repo
        }

        cd () {
          builtin cd "$@" || return
          check_for_repo
        }

        switch-remote () {
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          nixos-rebuild switch --flake . --use-remote-sudo --target-host "$@"
          git add .
          builtin cd - || return
        }

        boot-remote () {
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          nixos-rebuild boot --flake . --use-remote-sudo --target-host "$@"
          git add .
          builtin cd - || return
        }

        switch () {
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          sudo nixos-rebuild switch --flake .
          git add .
          builtin cd - || return
        }

        boot () {
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          git add .
          sudo nixos-rebuild boot --flake .
          git add .
          builtin cd - || return
        }

        update () {
          builtin cd "$FLAKE_PATH" || return
          clear
          $fetch_cmd
          nix flake update --flake . --commit-lock-file
          builtin cd - || return
        }

        nixgit () {
          builtin cd "$FLAKE_PATH" || return
          lazygit
          builtin cd - || return
        }

        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        source <(fzf --zsh)

        # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


        if [ "$class" = "fastfetch" ];
        then
          fastfetch --logo "$HOME"/Pictures/fastfetch_logos/Nakari.jpg --logo-padding-top 1
        else
          check_for_repo
        fi
      '';
  };
}
