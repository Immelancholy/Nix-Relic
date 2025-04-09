{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdchck.sh" ''
      while :
      do
        state=$(mpc status %state%)
        if [ "$state" = "playing" ];
        then
          sr.sh
        fi
      done
    '')
  ];
  systemd.user.services."mpdchck" = {
    enable = true;
    name = "mpdchck";
    after = ["mpd.service"];
    wantedBy = ["default.target"];
    path = [
      "/run/current-system/sw"
    ];
    script = ''mpdchck.sh'';
    serviceConfig = {
      Restart = "always";
    };
    environment = {
      MPD_HOST = "/run/user/1000/mpd/socket";
    };
  };
}
