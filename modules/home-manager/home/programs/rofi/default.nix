{
  config,
  pkgs,
  ...
}:
let
  cfg = config;
  inherit (cfg.stylix) fonts;
in
{
  programs.rofi = {
    enable = true;
    font = "${fonts.monospace.name} ${toString fonts.sizes.desktop}";
    terminal = cfg.home.sessionVariables.TERMINAL;
    plugins = with pkgs; [
      rofi-nerdy
      rofi-emoji
    ];
    modes = [
      "drun"
      "run"
      "filebrowser"
      "window"
    ];
    extraConfig = {
      # hover-select = true;
      # me-select-entry = "";
      # me-accept-entry = "MousePrimary";
      show-icons = true;
      display-drun = " Apps";
      display-run = "󰲌 Run";
      display-filebrowser = " Files";
      display-window = " Win";
      display-emoji = "󰱨 Emoji";
      display-nerdy = " Nerd";
      display-Cliphist = " Clip";
      drun-display-format = "{icon} {name}";
      window-format = "{w} · {c}";
      # icon-theme = "Papirus-Dark";
      # icon-theme = "Tela-circle-dracula";
      kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "Control+Shift+e";
      kb-mode-next = "Shift+Right,Control+Tab,Control+l";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
      kb-remove-char-back = "BackSpace";
      kb-mode-complete = "Control+Shift+l";
    };
  };
  imports = [
    ./theme.nix
  ];
}
