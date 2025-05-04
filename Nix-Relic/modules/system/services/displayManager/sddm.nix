{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.displayManager.sddm;

  base = "#${config.lib.stylix.colors.base00}";
  mantle = "#${config.lib.stylix.colors.base01}";
  surface0 = "#${config.lib.stylix.colors.base02}";
  surface1 = "#${config.lib.stylix.colors.base03}";
  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  rosewater = "#${config.lib.stylix.colors.base06}";
  lavender = "#${config.lib.stylix.colors.base07}";
  red = "#${config.lib.stylix.colors.base08}";
  peach = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  teal = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  mauve = "#${config.lib.stylix.colors.base0E}";
  flamingo = "#${config.lib.stylix.colors.base0F}";
in {
  options.displayManager.sddm = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use sddm as display manager'';
    };
    animatedBackground = {
      enable = mkEnableOption "Use animated background for sddm";
      path = mkOption {
        type = types.path;
        default = null;
        description = "Path to animated background";
      };
    };
    screenWidth = mkOption {
      type = types.str;
      default = "1920";
      description = "Width of monitor";
    };
    screenHeight = mkOption {
      type = types.str;
      default = "1080";
      description = "Height of monitor";
    };
  };
  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "weston";
      };
      autoNumlock = true;
      package = pkgs.kdePackages.sddm;
      enableHidpi = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          CursorTheme = config.stylix.cursor.name;
          CursorSize = config.stylix.cursor.size;
        };
      };
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
        kdePackages.qtmultimedia
      ];
    };

    environment.systemPackages = with pkgs; [
      (sddm-astronaut.override {
        themeConfig = {
          ScreenWidth = cfg.screenWidth;
          ScreenHeight = cfg.screenHeight;

          Font = config.stylix.fonts.sansSerif.name;
          FontSize = "12";

          RoundCorners = "20";

          BackgroundPlaceholder = "${config.stylix.image}";
          Background =
            if cfg.animatedBackground.enable
            then "${cfg.animatedBackground.path}"
            else "${config.stylix.image}";
          BackgroundSpeed = "1.0";
          PauseBackground = "";
          CropBackground = "false";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment = "center";
          DimBackground = "0.0";
          HeaderTextColor = "${text}";
          DateTextColor = "${text}";
          TimeTextColor = "${text}";

          FormBackgroundColor = "${base}";
          BackgroundColor = "${base}";
          DimBackgroundColor = "${base}";

          LoginFieldBackgroundColor = "#${base}";
          PasswordFieldBackgroundColor = "${base}";
          LoginFieldTextColo = "${mauve}";
          PasswordFieldTestColor = "${mauve}";
          UserIconColor = "${mauve}";
          PasswordIconColor = "${mauve}";

          PlaceholderTextColor = "${surface2}";
          WarningColor = "${red}";

          LoginButtonTextColor = "${mauve}";
          LoginButtonBackgroundColor = "${base}";
          SystemButtonsIconsColor = "${mauve}";
          SessionButtonTextColor = "${mauve}";
          VirtualKeyboardButtonTextColor = "${mauve}";

          DropdownTextColor = "${mauve}";
          DropdownSelectedBackgroundColor = "${base}";
          DropdownBackgroundColor = "${base}";

          HighlightTextColor = "${mauve}";
          HighlightBackgroundColor = "${mauve}";
          HighlightBorderColor = "${mauve}";

          HoverUserIconColor = "${teal}";
          HoverPasswordIconColor = "${teal}";
          HoverSystemButtonsIconsColor = "${teal}";
          HoverSessionButtonTextColor = "${teal}";
          HoverVirtualKeyboardButtonTextColor = "${teal}";

          PartialBlur = "true";
          BlurMax = "35";
          Blur = "2.0";

          HaveFormBackground = "false";
          FormPosition = "left";
        };
      })
    ];
  };
}
