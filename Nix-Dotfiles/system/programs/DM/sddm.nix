{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.displayManager.sddm;
in {
  options.displayManager.sddm = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use sddm as display manager'';
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
          CursorTheme = "Bibata-Modern-Ice";
          CursorSize = 20;
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
          ScreenWidth = "1920";
          ScreenHeight = "1080";

          Font = "Noto Sans Nerd Font";
          FontSize = "12";

          RoundCorners = "20";

          BackgroundPlaceholder = "${../../../home/backgrounds/Neon-Beast-Girl.png}";
          Background = "${../../../home/backgrounds/Neon-Beast-Girl.mp4}";
          BackgroundSpeed = "1.0";
          PauseBackground = "";
          CropBackground = "false";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment = "center";
          DimBackground = "0.0";
          HeaderTextColor = "#cdd6f4";
          DateTextColor = "#cdd6f4";
          TimeTextColor = "#cdd6f4";

          FormBackgroundColor = "#1e1e2e";
          BackgroundColor = "#1e1e2e";
          DimBackgroundColor = "#1e1e2e";

          LoginFieldBackgroundColor = "##1e1e2e";
          PasswordFieldBackgroundColor = "#1e1e2e";
          LoginFieldTextColo = "#cba6f7";
          PasswordFieldTestColor = "#cba6f7";
          UserIconColor = "#cba6f7";
          PasswordIconColor = "#cba6f7";

          PlaceholderTextColor = "#a6adc8";
          WarningColor = "#f38ba8";

          LoginButtonTextColor = "#cba6f7";
          LoginButtonBackgroundColor = "#1e1e2e";
          SystemButtonsIconsColor = "#cba6f7";
          SessionButtonTextColor = "#cba6f7";
          VirtualKeyboardButtonTextColor = "#cba6f7";

          DropdownTextColor = "#cba6f7";
          DropdownSelectedBackgroundColorrr = "#1e1e2e";
          DropdownBackgroundColor = "#1e1e2e";

          HighlightTextColor = "#cba6f7";
          HighlightBackgroundColor = "#cba6f7";
          HighlightBorderColor = "#cba6f7";

          HoverUserIconColor = "#91d7e3";
          HoverPasswordIconColor = "#91d7e3";
          HoverSystemButtonsIconColor = "#91d7e3";
          HoverSessionButtonTextColor = "#91d7e3";
          HoverVirtualKeyboardButtonTextColor = "#91d7e3";

          PartialBlue = "true";
          BlurMax = "35";
          Blur = "2.0";

          HaveFormBackground = "false";
          FormPosition = "left";
        };
      })
    ];
  };
}
