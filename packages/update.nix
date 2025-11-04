{
  writeShellScriptBin,
  flakePath ? "/etc/nixos",
  host ? "nix-relic",
  withToken ? false,
  ...
}: let
  flakeUpdateCmd =
    if withToken == true
    then ''nix flake update --commit-lock-file --option access-tokens "github.com=$(gh auth token)"''
    else "nix flake update --commit-lock-file";
in
  writeShellScriptBin "update-system" ''
    update () {
      ${flakeUpdateCmd}

      echo "Password for sudo:"

      sudo nixos-rebuild boot --flake .#${host} |& nom

      if [ $? -eq 0 ]; then
        booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
        built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

        if [ "''${booted}" = "''${built}" ]; then
          sudo nixos-rebuild switch --flake .#${host} |& nom
          echo "Updates Complete!"
        else
          echo "Updates Complete! Please reboot system after exit."
        fi

        sleep 1

        while true; do

          read -p "Would you like to push updates to github? [y/N]" yn

          if [[ "$yn" == "" ]]; then
            yn=n
          fi

          case $yn in
              [yY] ) git push;
                  break;;
              [nN] )
                  break;;
              * ) echo "Invalid Response";;
          esac

        done

        sleep 1

        read -n 1 -p 'Press any key to continue...'
        exit 0
      fi

      echo "Updates failed!"
      sleep 1
      read -n 1 -p 'Press any key to continue...'
      exit 1

    }
    builtin cd "${flakePath}" || return
    clear
    fastfetch

    while true; do

      read -p "Would you like to update your system? [Y/n]" yn

      if [[ "$yn" == "" ]]; then
        yn=y
      fi

      case $yn in
          [yY] ) echo "Updating System...";
              break;;
          [nN] ) echo "Exiting...";
              exit;;
          * ) echo "Invalid Response";;
      esac

    done
    update

  ''
