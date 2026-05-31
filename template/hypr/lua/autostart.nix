{
  xdg.configFile."hypr/lua/autostart.lua".text =
    /*
    Lua
    */
    ''
      local browser = Browser
      local discord = Discord
      local editor = Editor
      local files = Files
      local filest = Filest
      local menu = Editor
      local mod = Mod
      local moda = Moda
      local modc = Modc
      local mods = Mods
      local player = Player
      local playerctl = Playerctl
      local scr = Scr
      local term = Term

      hl.on("hyprland.start", function()
      	hl.exec_cmd("uwsm app -- " .. discord)
      	hl.exec_cmd(browser, { workspace = "2 silent" })
      end)
    '';
}
