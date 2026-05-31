{
  xdg.configFile."hypr/hyprland.lua".text =
    /*
    Lua
    */
    ''
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

      Browser = "uwsm app -- zen-beta.desktop"
      Discord = "uwsm app -- vesktop.desktop"
      Editor = "uwsm app -- nvim.desktop"
      Files = "uwsm app -- nemo.desktop"
      Filest = "uwsm app -- yazi.desktop"
      Menu =
      	'rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,fibrowser,power-menu:rofi-power-menu'
      Mod = "SUPER"
      Moda = "SUPER + ALT"
      Modc = "SUPER + CTRL"
      Mods = "SUPER + SHIFT"
      Player = "mpd"
      Playerctl = ("uwsm app -- playerctl --player=" .. Player)
      Scr = "$XDG_BIN_HOME"
      Term = "uwsm app -- kitty"

      hl.config({
      	general = {
      		layout = "scrolling",
      	},
      })

      load_module("autostart")
      load_module("binds")
      load_module("hardware")
      load_module("permissions")
      load_module("plugins")
      load_module("rules")
      load_module("theme")
    '';
  imports = [
    ./lua/autostart.nix
    ./lua/binds.nix
    ./lua/hardware.nix
    ./lua/permissions.nix
    ./lua/plugins.nix
    ./lua/rules.nix
    ./lua/theme.nix
  ];
}
