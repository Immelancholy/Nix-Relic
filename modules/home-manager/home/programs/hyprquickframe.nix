{
  pkgs,
  inputs,
  config,
  ...
}: let
  base00 = "#${config.lib.stylix.colors.base00}";
  base01 = "#${config.lib.stylix.colors.base01}";
  base02 = "#${config.lib.stylix.colors.base02}";
  base03 = "#${config.lib.stylix.colors.base03}";
  base04 = "#${config.lib.stylix.colors.base04}";
  base05 = "#${config.lib.stylix.colors.base05}";
  base06 = "#${config.lib.stylix.colors.base06}";
  base07 = "#${config.lib.stylix.colors.base07}";
  base08 = "#${config.lib.stylix.colors.base08}";
  base09 = "#${config.lib.stylix.colors.base09}";
  base0A = "#${config.lib.stylix.colors.base0A}";
  base0B = "#${config.lib.stylix.colors.base0B}";
  base0C = "#${config.lib.stylix.colors.base0C}";
  base0D = "#${config.lib.stylix.colors.base0D}";
  base0E = "#${config.lib.stylix.colors.base0E}";
  base0F = "#${config.lib.stylix.colors.base0F}";
in {
  home.packages = [
    inputs.nix-relic.inputs.hyprquickframe.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  xdg.configFile."hyprquickframe/theme.toml".text = ''
    # Main highlight color on the active tab
    accent = "${base04}"
    # Text color on the active tab (should contrast with accent)
    accentText = "${base00}"
    # Dim overlay opacity when selecting (0.0 - 1.0)
    dimOpacity = 0.6
    # Corner radius on selection outline
    borderRadius = 15
    # Selection outline thickness
    outlineThickness = 2
    # Distance from bottom edge to the bar
    bottomMargin = 60
    # Global animation toggle (true/false)
    animations = true
    # Tool to use for the "edit" screenshot action (e.g., "satty" or "gradia")
    annotationTool = "satty"

    [bar]
    # Segmented control background
    background = "${base01}66"
    # Segmented control border
    border = "${base05}26"
    # Inactive tab text color
    text = "${base05}"
    # Drop shadow under the bar
    shadow = "#80000000"

    [toggle]
    # Drop shadow under toggle pills
    shadow = "#80000000"
    # Edit toggle icon color
    edit = "#1ABC9C"
    # Temp toggle icon color
    temp = "#2C66D8"

    [share]
    # Icon color when device is reachable
    connected = "#3498DB"
    # Icon color while checking connectivity
    pending = "#95A5A6"
    # Icon color on connection failure
    errorIcon = "white"
    # Background color on connection failure
    errorBackground = "#E74C3C"

    [hooks]
    # Command to run after a screenshot is saved (leave empty to disable)
    # Placeholders: %f = full path, %n = filename, %d = directory, %t = timestamp
    postSaveHook = ""
  '';
}
