{
  writeShellScriptBin,
  flakePath ? "",
  host ? "",
  ...
}:
writeShellScriptBin "update-system" ''
  onefetch_img () {
    image="$(find ~/Pictures/fastfetch_logos/ -name "*.jpg" -o -name "*.png" 2> /dev/null | shuf -n1)"
    if [ "$image" ]; then
      onefetch --image-protocol kitty -i "$image"
    else
      onefetch
    fi
  }
  update () {
    builtin cd "${flakePath}" || return
    clear
    onefetch_img
    nix flake update --commit-lock-file
    sudo nixos-rebuild boot --flake .#${host} |& nom

    if [ $? -eq 0 ]; then
      booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
      built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

      if [ "''${booted}" = "''${built}" ]; then
        sudo nixos-rebuild switch --flake .#${host} |& nom
      fi

      echo "Updates Complete!"
      sleep 1
      read -n 1 -p 'Press any key to continue...'
      exit 0
    fi

    echo "Updates failed!"
    sleep 1
    read -n 1 -p 'Press any key to continue...'
    exit 1

  }

  while true; do

    read -p "Would you like to update your system? [Y/n]" yn

    if [ $yn = "" ]; then
      $yn="y"
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
