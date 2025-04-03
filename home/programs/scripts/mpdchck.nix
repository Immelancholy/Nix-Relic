{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "mpdchck.sh" ''
      while :
      do
        state=$(mpc status %state%)
        if [ "$state" = "playing" ];
        then
          uwsm app -- sr.sh
        fi
      done
    '')
  ];
}
