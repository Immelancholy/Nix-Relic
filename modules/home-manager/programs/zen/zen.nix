{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.zen-browser;
  user = config.home.username;
in {
  config = mkIf cfg.enable {
    xdg.configFile = {
      "zen/profiles.ini".text = ''
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
  };
}
