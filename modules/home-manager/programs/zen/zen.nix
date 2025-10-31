{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.zen-browser;
  user = config.home.username;
  associations = {
    "text/html" = ["${cfg.defaultBrowser.desktopFile}"];
    "x-scheme-handler/http" = ["${cfg.defaultBrowser.desktopFile}"];
    "x-scheme-handler/https" = ["${cfg.defaultBrowser.desktopFile}"];
    "x-scheme-handler/chrome" = ["${cfg.defaultBrowser.desktopFile}"];
    "x-scheme-handler/about" = ["${cfg.defaultBrowser.desktopFile}"];
    "x-scheme-handler/unknown" = ["${cfg.defaultBrowser.desktopFile}"];
    "default-web-browser" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/xhtml+xml" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/xhtml_xml" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/x-extension-htm" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/x-extension-html" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/x-extension-shtml" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/x-extension-xhtml" = ["${cfg.defaultBrowser.desktopFile}"];
    "application/x-extension-xht" = ["${cfg.defaultBrowser.desktopFile}"];
  };
in {
  options.programs.zen-browser = {
    defaultBrowser = {
      enable = mkEnableOption "Make Zen the default browser";
      desktopFile = mkOption {
        type = types.str;
        default = "zen.desktop";
        description = "Name of zen browser desktop file";
      };
    };
  };
  config = mkIf cfg.enable {
    home.file = {
      ".zen/profiles.ini".text = ''
        [Profile0]
        Name=${user}Default
        IsRelative=1
        Path=${user}.Default
        ZenAvatarPath=chrome://browser/content/zen-avatars/avatar-82.svg
        Default=1

        [General]
        StartWithLastProfile=1
        Version=2
      '';
    };
    xdg.mime = mkIf (cfg.enable && cfg.defaultBrowser.enable) {
      enable = true;
    };
    xdg.mimeApps = mkIf (cfg.enable && cfg.defaultBrowser.enable) {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
    home.sessionVariables = mkIf (cfg.enable && cfg.defaultBrowser.enable) {
      BROWSER = "zen";
    };
  };
}
