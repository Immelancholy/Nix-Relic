{ config, ... }:
let
  inherit (config.player) cmd class title;
in
{
  xdg.configFile."hypr/variables.lua".text = /* Lua */ ''
    Term = "uwsm-app -- kitty"
    Browser = "uwsm-app -- zen-beta.desktop"
    Discord = "uwsm-app -- vesktop.desktop"
    Editor = "uwsm-app -- org.neovim.nvim.desktop"
    Files = "uwsm-app -- yazi.desktop"
    Menu =
      'rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'
    Mod = "SUPER"
    Moda = "SUPER + ALT"
    Modc = "SUPER + CTRL"
    Mods = "SUPER + SHIFT"
    Player = (
      "uwsm-app -- "
      .. Term
      .. " --title ${title} --class ${class} ${cmd}"
    )
    Playerctl = "uwsm-app -- playerctl --player=${class}"
  '';
}
