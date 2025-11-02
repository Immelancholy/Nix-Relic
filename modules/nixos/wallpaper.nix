{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic.wallpaper;
in {
  options.nix-relic.wallpaper = {
    path = mkOption {
      type = types.path;
      default = null;
      description = "Path to wallpaper image (Must be set)";
    };
    polarity = mkOption {
      type = types.str;
      default = "dark";
      description = "Polarity of generated colours, either dark or light";
    };
    animatedWallpaper = {
      enable = mkEnableOption "Whether to use an animated Wallpaper";
      path = mkOption {
        type = types.path;
        default = null;
        description = "Path to animated wallpaper";
      };
    };
  };
  config = mkMerge [
    {
      stylix = {
        polarity = cfg.polarity;
        image = cfg.path;
      };
    }
    (
      if
        cfg.path
        == "${nix-relic}/backgrounds/Sailor_Moon.png"
        || cfg.path == "${nix-relic}/backgrounds/Surtur.png"
      then {
        nix-relic.icons.colour = "red";
      }
      else if
        cfg.path
        == "${nix-relic}/backgrounds/Momo_Smoke.png"
        || cfg.path
        == "${nix-relic}/backgrounds/Evil_Miku.png"
      then {
        nix-relic.icons.colour = "dracula";
      }
      else {
      }
    )
  ];
}
