{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.qpwgraph;
in {
  options.services.qpwgraph = {
    enable = mkEnableOption "Enable qpwgraph service";
  };
  config = mkIf cfg.enable {
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
  };
}
