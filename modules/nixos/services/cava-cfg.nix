{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.services.cava-cfg;
  inherit (inputs) nix-relic;
  cava-cfg = nix-relic.packages.${pkgs.stdenv.hostPlatform.system}.cava-cfg.override {
    color1 = "${cfg.colors.color1}";
    color2 = "${cfg.colors.color2}";
    color3 = "${cfg.colors.color3}";
    color4 = "${cfg.colors.color4}";
    color5 = "${cfg.colors.color5}";
    color6 = "${cfg.colors.color6}";
    color7 = "${cfg.colors.color7}";
    framerate = "${toString cfg.framerate}";
    noiseReduction = "${toString cfg.noiseReduction}";
  };
in
{
  options.services.cava-cfg = {
    enable = lib.mkEnableOption "Enable neo color file generation service";
    framerate = lib.mkOption {
      type = lib.types.int;
      default = 60;
    };
    noiseReduction = lib.mkOption {
      type = lib.types.int;
      default = 30;
    };
    colors = {
      color1 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      color2 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      color3 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      color4 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      color5 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      color6 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      color7 = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services."cava-cfg" = {
      enable = true;
      name = "Configure Cava";
      wantedBy = [ "default.target" ];
      path = [
        cava-cfg
      ];
      script = "cava-cfg";
    };
  };
}
