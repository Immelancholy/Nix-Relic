{
  restarts ? ''exit'',
  writeShellApplication,
}:
writeShellApplication {
  name = "systemd-restarts";

  text = ''
    #!/usr/bin/env sh

    restarts () {
      ${restarts}
    }

    restarts

  '';
}
