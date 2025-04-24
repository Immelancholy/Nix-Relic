{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.vesktop;
  flavor = config.catppuccin.flavor;
  accent = config.catppuccin.accent;
in {
  config = mkIf (! cfg.enable) {
    xdg.configFile."vesktop/themes/stylix.theme.css".text = ''
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-${flavor}-${accent}.theme.css");
    '';
  };
}
