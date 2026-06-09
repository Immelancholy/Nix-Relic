{ config, ... }:
let
  inherit (config.player) cmd class title;
in
{
  xdg.configFile."hypr/hyprland.lua".text = /* Lua */ ''
       if not hl then
         return
       end

       local user_home = os.getenv("HOME") or os.getenv("XDG_CONFIG_HOME") or ("/home/" .. (os.getenv("USER") or "unknown"))
       local lua_dir = user_home .. "/.config/hypr/lua/"

       local function load_module(name)
         local path = lua_dir .. name .. ".lua"
         local f = io.open(path, "r")
         if f then
           f:close()
           local ok, err = pcall(dofile, path)
           if not ok then
             io.stderr:write("[hyprland.lua] ERROR loading '" .. name .. "': " .. err .. "\n")
           end
         else
           io.stderr:write("[hyprland.lua] Module not found: " .. path .. "\n")
         end
       end

       Term = "uwsm-app -- kitty"
       Browser = "uwsm-app -- zen-beta.desktop"
       Discord = "uwsm-app -- vesktop.desktop"
       Editor = "uwsm-app -- org.neovim.nvim.desktop"
       Files = "uwsm-app -- nemo.desktop"
       Filest = "uwsm-app -- yazi.desktop"
       Menu =
         'rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'
       Mod = "SUPER"
       Moda = "SUPER + ALT"
       Modc = "SUPER + CTRL"
       Mods = "SUPER + SHIFT"
       Player = (
         "uwsm-app -- "
         .. Term
         .. " --title ${title} --class ${class}
    ${cmd}"
       )
       Playerctl = "uwsm-app -- playerctl --player=${class}"

       function Universal_User_Binds() end
       function Default_User_Binds() end
       function Manage_User_Binds() end
       function Resize_User_Binds() end
       function Move_User_Binds() end
       function Player_User_Binds() end

       load_module("autostart")
       load_module("binds")
       load_module("hardware")
       load_module("layouts")
       load_module("permissions")
       load_module("plugins")
       load_module("rules")
       load_module("theme")
  '';
}
