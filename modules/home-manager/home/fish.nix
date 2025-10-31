{pkgs, ...}: {
  programs.fish = {
    enable = true;
    generateCompletions = true;
    preferAbbrs = true;
    shellAbbrs = {
      ll = "eza -l";
      ls = "eza";
      edit = "sudo -e";
      cava = "cava.sh";
      firmware = "sudo systemctl reboot --firmware-setup";
      gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      nv = "nvim";
    };
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
    interactiveShellInit =
      /*
      fish
      */
      ''
        set -U fish_greeting
        function fish_mode_prompt; end
      '';
    shellInitLast =
      /*
      fish
      */
      ''
        fish_vi_key_bindings

        set -gx last_repo
        set -gx INIT 1

        function onefetch_img
          set image "$(find ~/Pictures/fastfetch_logos/ -name "*.jpg" -o -name "*.png" 2> /dev/null | shuf -n1)"
          if [ "$image" ]
            onefetch --image-protocol kitty -i "$image"
          else
            onefetch
          end
        end

        function check_tmux
          if [ -z $TMUX ]
            set -gx fetch_cmd onefetch_img
          else
            set -gx fetch_cmd fastfetch
          end
        end

        check_tmux

        function check_for_repo
          set -gx current_repo $(git rev-parse --show-toplevel 2> /dev/null)
          if [ "$current_repo" ] && \
            [ "$current_repo" != "$last_repo" ]
            clear
            $fetch_cmd
            set -gx last_repo $current_repo
            set -gx INIT 0
            set -gx GIT 1
          else if [ $INIT -eq 1 ]
            clear
            pokeget fennekin --hide-name
            set -gx INIT 0
            set -gx GIT 0
          else if [ ! "$current_repo" ] && \
            [ $GIT = 1 ]
            clear
            pokeget fennekin --hide-name
            set -gx GIT 0
            set -gx last_repo
          end
        end

        function nextd --description "Move forward in the directory history"
            set -l options h/help l/list
            argparse -n nextd --max-args=1 $options -- $argv
            or return

            if set -q _flag_help
                __fish_print_help nextd
                return 0
            end

            set -l times 1
            if set -q argv[1]
                if test $argv[1] -ge 0 2>/dev/null
                    set times $argv[1]
                else
                    printf (_ "%s: The number of positions to skip must be a non-negative integer\n") nextd >&2
                    return 1
                end
            end

            # Traverse history
            set -l code 1
            for i in (seq $times)
                # Try one step backward
                if __fish_move_last dirnext dirprev
                    # We consider it a success if we were able to do at least 1 step
                    # (low expectations are the key to happiness ;)
                    set code 0
                else
                    break
                end
            end

            # Show history if needed
            if set -q _flag_list
                dirh
            end

            # Set direction for 'cd -'
            test $code = 0
            and set -g __fish_cd_direction prev

            check_for_repo
            return $code
        end

        function prevd --description "Move back in the directory history"
            set -l options h/help l/list
            argparse -n prevd --max-args=1 $options -- $argv
            or return

            if set -q _flag_help
                __fish_print_help prevd
                return 0
            end

            set -l times 1
            if set -q argv[1]
                if test $argv[1] -ge 0 2>/dev/null
                    set times $argv[1]
                else
                    printf (_ "%s: The number of positions to skip must be a non-negative integer\n") prevd >&2
                    return 1
                end
            end

            # Traverse history
            set -l code 1
            for i in (seq $times)
                # Try one step forward
                if __fish_move_last dirprev dirnext
                    # We consider it a success if we were able to do at least 1 step
                    # (low expectations are the key to happiness ;)
                    set code 0
                else
                    break
                end
            end

            # Show history if needed
            if set -q _flag_list
                dirh
            end

            # Set direction for 'cd -'
            test $code = 0
            and set -g __fish_cd_direction next

            check_for_repo
            return $code
        end

        function cd --description "Change directory"
            set -l MAX_DIR_HIST 25

            if set -q argv[2]; and begin
                    set -q argv[3]
                    or not test "$argv[1]" = --
                end
                printf "%s\n" (_ "Too many args for cd command") >&2
                return 1
            end

            # Skip history in subshells.
            if status --is-command-substitution
                builtin cd $argv
                return $status
            end

            # Avoid set completions.
            set -l previous $PWD

            if test "$argv" = -
                if test "$__fish_cd_direction" = next
                    nextd
                else
                    prevd
                end
                return $status
            end

            builtin cd $argv
            set -l cd_status $status

            if test $cd_status -eq 0 -a "$PWD" != "$previous"
                set -q dirprev
                or set -l dirprev
                set -q dirprev[$MAX_DIR_HIST]
                and set -e dirprev[1]

                # If dirprev, dirnext, __fish_cd_direction
                # are set as universal variables, honor their scope.

                set -U -q dirprev
                and set -U -a dirprev $previous
                or set -g -a dirprev $previous

                set -U -q dirnext
                and set -U -e dirnext
                or set -e dirnext

                set -U -q __fish_cd_direction
                and set -U __fish_cd_direction prev
                or set -g __fish_cd_direction prev
            end

            check_for_repo
            return $cd_status
        end

        function cdh --description "Menu based cd command"
            # See if we've been invoked with an argument. Presumably from the `cdh` completion script.
            # If we have just treat it as `cd` to the specified directory.
            if set -q argv[1]
                cd $argv
                return
            end

            if set -q argv[2]
                echo (_ "cdh: Expected zero or one arguments") >&2
                return 1
            end

            set -l all_dirs $dirprev $dirnext
            if not set -q all_dirs[1]
                echo (_ 'No previous directories to select. You have to cd at least once.') >&2
                return 0
            end

            # Reverse the directories so the most recently visited is first in the list.
            # Also, eliminate duplicates; i.e., we only want the most recent visit to a
            # given directory in the selection list.
            set -l uniq_dirs
            for dir in $all_dirs[-1..1]
                if not contains $dir $uniq_dirs
                    set -a uniq_dirs $dir
                end
            end

            set -l letters a b c d e f g h i j k l m n o p q r s t u v w x y z
            set -l dirc (count $uniq_dirs)
            if test $dirc -gt (count $letters)
                set -l msg (_ 'This should not happen. Have you changed the cd function?')
                printf "$msg\n" >&2
                set -l msg (_ 'There are %s unique dirs in your history but I can only handle %s')
                printf "$msg\n" $dirc (count $letters) >&2
                return 1
            end

            # Print the recent directories, oldest to newest. Since we previously
            # reversed the list, making the newest entry the first item in the array,
            # we count down rather than up.
            for i in (seq $dirc -1 1)
                set -l dir $uniq_dirs[$i]
                set -l label_color normal
                set -q fish_color_cwd
                and set label_color $fish_color_cwd
                set -l dir_color_reset (set_color normal)
                set -l dir_color
                if test "$dir" = "$PWD"
                    set dir_color (set_color $fish_color_history_current)
                end

                set -l home_dir (string match -r "^$HOME(/.*|\$)" "$dir")
                if set -q home_dir[2]
                    set dir "~$home_dir[2]"
                end
                printf '%s %s %2d) %s %s%s%s\n' (set_color $label_color) $letters[$i] $i (set_color normal) $dir_color $dir $dir_color_reset
            end

            # Ask the user which directory from their history they want to cd to.
            set -l msg (_ 'Select directory by letter or number: ')
            read -l -p "echo '$msg'" choice
            if test -z "$choice"
                return 0
            else if string match -q -r '^[a-z]$' $choice
                # Convert the letter to an index number.
                set choice (contains -i $choice $letters)
            end

            set -l msg (_ 'Error: expected a number between 1 and %d or letter in that range, got "%s"')
            if string match -q -r '^\d+$' $choice
                if test $choice -ge 1 -a $choice -le $dirc
                    cd $uniq_dirs[$choice]
                    return
                else
                    printf "$msg\n" $dirc $choice >&2
                    return 1
                end
            else
                printf "$msg\n" $dirc $choice >&2
                return 1
            end
            check_for_repo
        end

        function z -w='z'
          __zoxide_z $argv
          check_for_repo
        end

        function zi -w='zi'
          __zoxide_zi $argv
          check_for_repo
        end

        function switch-remote -w='switch-remote'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          git add .
          nixos-rebuild switch --flake . --sudo --ask-sudo-password --target-host $argv &| nom
          git add .
          cd "$dir"
        end

        function boot-remote -w='boot-remote'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          git add .
          nixos-rebuild boot --flake . --sudo --ask-sudo-password --target-host $argv &| nom
          git add .
          cd "$dir"
        end

        function switch-build -w='switch-build'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          git add .
          sudo nixos-rebuild switch --flake . &| nom
          git add .
          cd "$dir"
        end

        function boot -w='boot'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          git add .
          sudo nixos-rebuild boot --flake . &| nom
          git add .
          cd "$dir"
        end

        function update -w='update'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          nix flake update --flake . --commit-lock-file
          cd "$dir"
        end

        function nixgit -w='nixgit'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          lazygit
          cd "$dir"
        end

        function nix-llm-git -w='nix-llm-git'
          set -l dir "$(pwd)"
          cd "$FLAKE_PATH"
          llm git-commit
          cd "$dir"
        end

        if [ "$class" = "fastfetch" ]
          fastfetch --logo "$HOME"/Pictures/fastfetch_logos/Nakari.jpg
        else
          check_for_repo
        end
      '';
  };
}
