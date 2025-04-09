{pkgs, ...}: {
  systemd.user.services."qpwgraph" = {
    enable = true;
    name = "qpwgraph";
    after = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
    path = [
      "${pkgs.qpwgraph}"
    ];
    script = ''
      qpwgraph
      qpwgraph
    '';
    serviceConfig = {
      Restart = "always";
    };
  };
}
