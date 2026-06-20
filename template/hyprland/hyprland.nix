{
  xdg.configFile."hypr/hyprland.lua".text = /* Lua */ ''
    require("variables")
    require("userconf")
    require("autostart")
    require("binds")
    require("hardware")
    require("layouts")
    require("permissions")
    require("plugins")
    require("rules")
    require("theme")
  '';
}
