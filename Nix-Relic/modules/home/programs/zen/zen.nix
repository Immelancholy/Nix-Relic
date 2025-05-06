{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.zen;
  user = config.home.username;
  associations = {
    "text/html" = ["zen.desktop"];
    "x-scheme-handler/http" = ["zen.desktop"];
    "x-scheme-handler/https" = ["zen.desktop"];
    "x-scheme-handler/chrome" = ["zen.desktop"];
    "x-scheme-handler/about" = ["zen.desktop"];
    "x-scheme-handler/unknown" = ["zen.desktop"];
    "default-web-browser" = ["zen.desktop"];
    "application/pdf" = ["zen.desktop"];
    "application/xhtml+xml" = ["zen.desktop"];
    "application/xhtml_xml" = ["zen.desktop"];
    "application/x-extension-htm" = ["zen.desktop"];
    "application/x-extension-html" = ["zen.desktop"];
    "application/x-extension-shtml" = ["zen.desktop"];
    "application/x-extension-xhtml" = ["zen.desktop"];
    "application/x-extension-xht" = ["zen.desktop"];
  };
in {
  options.programs.zen = {
    enable = mkEnableOption "Enable Zen Browser";
    defaultBrowser = mkEnableOption "Make Zen the default browser";
  };
  config = mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
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
    xdg.mime = mkIf (cfg.enable && cfg.defaultBrowser) {
      enable = true;
    };
    xdg.mimeApps = mkIf (cfg.enable && cfg.defaultBrowser) {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
