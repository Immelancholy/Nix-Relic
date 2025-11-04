{
  writeShellScriptBin,
  flakePath ? "/etc/nixos",
  host ? "nix-relic",
  withToken ? false,
  ...
}: let
  flakeUpdateCmd =
    if withToken == true
    then ''nix flake update --option access-tokens "github.com=$(gh auth token)"''
    else "nix flake update";
in
  writeShellScriptBin "update-system" ''
    update () {
      ${flakeUpdateCmd}

      git diff --exit-code -- flake.lock > /dev/null 2>&1

      if [ $? -eq 0 ]; then
        echo "No updates found!"
        sleep 1
        read -n 1 -p 'Press any key to exit...'
        exit 0
      fi

      git restore flake.lock

      ${flakeUpdateCmd} --commit-lock-file

      echo "Password for sudo:"

      sudo nixos-rebuild boot --flake .#${host} |& nom

      if [ $? -eq 0 ]; then
        booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
        built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

        echo "Updates Complete!"

        if [ "''${booted}" = "''${built}" ]; then
          echo "Applying Updates..."
          sudo nixos-rebuild switch --flake .#${host} |& nom
          if [ $? -eq 0 ]; then
            echo "Updates applied succesfully."
          else
            echo "Error applying updates."
          fi
        else
          echo "Booted system is different to built system! Please reboot to apply update"
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

        read -n 1 -p 'Press any key to exit...'
        exit 0
      fi

      echo "Updates failed!"
      sleep 1
      read -n 1 -p 'Press any key to exit...'
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
