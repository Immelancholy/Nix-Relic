{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.services.mpdchck;
  mpdchck = pkgs.callPackage ../../../packages/mpdchck.nix {};
in {
  options.services.mpdchck = {
    enable = mkEnableOption "Enable mpdchck service";
    address = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Host address for mpd";
    };
    port = mkOption {
      type = types.port;
      default = 6600;
      description = "Port for mpd";
    };
  };
  config = mkIf cfg.enable {
    systemd.user.services."mpdchck" = {
      enable = true;
      name = "mpdchck";
      after = ["mpd.service"];
      wantedBy = ["default.target"];
      script = ''${mpdchck}/bin/mpdchck.sh'';
      serviceConfig = {
        Restart = "always";
      };
      environment = {
        MPD_HOST = cfg.address;
        MPD_PORT = builtins.toString cfg.port;
      };
    };
  };
}
