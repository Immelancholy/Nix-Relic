{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.displayManager.sddm;
  abg = config.nix-relic.wallpaper;

  base = "#${config.lib.stylix.colors.base00}";
  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  red = "#${config.lib.stylix.colors.base08}";
  teal = "#${config.lib.stylix.colors.base0C}";
  mauve = "#${config.lib.stylix.colors.base0E}";
in {
  options.displayManager.sddm = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use sddm as display manager'';
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
    environment.sessionVariables = {
      DISPLAY_MANAGER = "sddm";
    };
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
            if abg.animatedWallpaper.enable
            then "${abg.animatedWallpaper.path}"
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
