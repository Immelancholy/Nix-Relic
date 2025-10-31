{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.neo-color;
  neo-color = pkgs.callPackage ../../../packages/neo-color.nix {
    color1 = "${cfg.colors.color1}";
    color2 = "${cfg.colors.color2}";
    color3 = "${cfg.colors.color3}";
    color4 = "${cfg.colors.color4}";
    color5 = "${cfg.colors.color5}";
  };
in {
  options.services.neo-color = {
    enable = lib.mkEnableOption "Enable neo color file generation service";
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
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services."neo-color" = {
      enable = true;
      name = "Neo Color";
      wantedBy = ["default.target"];
      path = [
        neo-color
      ];
      script = ''neo-color'';
    };
  };
}
