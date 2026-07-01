self:
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.quickshell-overview;
  quickshell-overview = self.packages.${pkgs.stdenv.hostPlatform.system}.quickshell-overview;
  jsonFormat = pkgs.formats.json { };
  colorOpts = {
    options = {
      enable = mkEnableOption "Enable custom colors";
      m3primary = mkOption {
        type = types.str;
        default = "";
      };
      m3onPrimary = mkOption {
        type = types.str;
        default = "";
      };

      m3primaryContainer = mkOption {
        type = types.str;
        default = "";
      };
      m3onPrimaryContainer = mkOption {
        type = types.str;
        default = "";
      };

      m3secondary = mkOption {
        type = types.str;
        default = "";
      };
      m3onSecondary = mkOption {
        type = types.str;
        default = "";
      };

      m3secondaryContainer = mkOption {
        type = types.str;
        default = "";
      };
      m3onSecondaryContainer = mkOption {
        type = types.str;
        default = "";
      };

      m3background = mkOption {
        type = types.str;
        default = "";
      };
      m3onBackground = mkOption {
        type = types.str;
        default = "";
      };

      m3surface = mkOption {
        type = types.str;
        default = "";
      };

      m3surfaceContainerLow = mkOption {
        type = types.str;
        default = "";
      };
      m3surfaceContainer = mkOption {
        type = types.str;
        default = "";
      };
      m3surfaceContainerHigh = mkOption {
        type = types.str;
        default = "";
      };
      m3surfaceContainerHighest = mkOption {
        type = types.str;
        default = "";
      };

      m3onSurface = mkOption {
        type = types.str;
        default = "";
      };

      m3surfaceVariant = mkOption {
        type = types.str;
        default = "";
      };
      m3onSurfaceVariant = mkOption {
        type = types.str;
        default = "";
      };

      m3inverseSurface = mkOption {
        type = types.str;
        default = "";
      };
      m3inverseOnSurface = mkOption {
        type = types.str;
        default = "";
      };

      m3outline = mkOption {
        type = types.str;
        default = "";
      };
      m3outlineVariant = mkOption {
        type = types.str;
        default = "";
      };

      m3shadow = mkOption {
        type = types.str;
        default = "";
      };
    };
  };
in
{
  options.programs.quickshell-overview = {
    enable = mkEnableOption "Enable quickshell-overview for hyprland";
    package = mkOption {
      type = with types; nullOr package;
      default = quickshell-overview;
    };
    colors = mkOption {
      type = with types; submodule colorOpts;
      default = { };
    };
    settings = mkOption {
      type = jsonFormat.type;
      default = { };
    };
  };

  config =
    let
      configSource = jsonFormat.generate "config.json" cfg.settings;
      colorSource =
        let
          inherit (cfg) colors;
        in
        with colors;
        pkgs.writeText "Appearance.colors.qml" /* qml */ ''
          import QtQuick

          QtObject {
              id: m3

              property color m3primary: "${m3primary}"
              property color m3onPrimary: "${m3onPrimary}"

              property color m3primaryContainer: "${m3primaryContainer}"
              property color m3onPrimaryContainer: "${m3onPrimaryContainer}"

              property color m3secondary: "${m3secondary}"
              property color m3onSecondary: "${m3onSecondary}"

              property color m3secondaryContainer: "${m3secondaryContainer}"
              property color m3onSecondaryContainer: "${m3onSecondaryContainer}"

              property color m3background: "${m3background}"
              property color m3onBackground: "${m3onBackground}"

              property color m3surface: "${m3surface}"

              property color m3surfaceContainerLow: "${m3surfaceContainerLow}"
              property color m3surfaceContainer: "${m3surfaceContainer}"
              property color m3surfaceContainerHigh: "${m3surfaceContainerHigh}"
              property color m3surfaceContainerHighest: "${m3surfaceContainerHighest}"

              property color m3onSurface: "${m3onSurface}"

              property color m3surfaceVariant: "${m3surfaceVariant}"
              property color m3onSurfaceVariant: "${m3onSurfaceVariant}"

              property color m3inverseSurface: "${m3inverseSurface}"
              property color m3inverseOnSurface: "${m3inverseOnSurface}"

              property color m3outline: "${m3outline}"
              property color m3outlineVariant: "${m3outlineVariant}"

              property color m3shadow: "${m3shadow}"
          }
        '';
      finalPackage =
        if (cfg.settings == { }) then
          cfg.package
        else if (cfg.colors.enable != true) then
          cfg.package.override { configFile = "${toString configSource}"; }
        else
          cfg.package.override {
            configFile = "${toString configSource}";
            colorFile = "${toString colorSource}";
          };
    in
    mkIf cfg.enable {
      programs.quickshell-overview = mkIf cfg.colors.enable {
        settings.appearance.colorSource = "matugen";
      };
      home.packages = mkIf (cfg.package != null) [ finalPackage ];
    };
}
