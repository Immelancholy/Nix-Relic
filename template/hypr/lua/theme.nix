{ config, ... }:
let
  colors = config.lib.stylix.colors;
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
in
with colors;
{
  xdg.configFile."hypr/lua/theme.lua".text = /* Lua */ ''

    hl.config({
    	general = {
    		gaps_in = 3,
    		gaps_out = 8,
    		border_size = 2,
    		col = {
    			active_border = { colors = { "${rgb base0E}", "${rgb base0C}", "${rgb base06}" }, angle = 40 },
    			inactive_border = { colors = { "${rgba base07 "cc"}", "${rgba base04 "cc"}" }, angle = 45 },
    		},
    		resize_on_border = true,
    		allow_tearing = true,
    	},
    	group = {
    		col = {
    			border_active = { colors = { "${rgb base0E}", "${rgb base0C}", "${rgb base06}" }, angle = 40 },
    			border_inactive = { colors = { "${rgba base07 "cc"}", "${rgba base04 "cc"}" }, angle = 45 },
    			border_locked_active = { colors = { "${rgb base0E}", "${rgb base0C}", "${rgb base06}" }, angle = 40 },
    			border_locked_inactive = { colors = { "${rgba base07 "cc"}", "${rgba base04 "cc"}" }, angle = 45 },
    		},
    		groupbar = {
    			font_family = "JetBrainsMono Nerd Font Mono Bold",
    			font_size = 12,
    			gradients = false,
    			text_color = "${rgb base05}",
    			col = {
    				active = "${rgb base0E}",
    				inactive = "${rgba base07 "cc"}",
    			},
    		},
    	},
    	decoration = {
    		rounding = 20,
    		shadow = {
    			enabled = false,
    			color = "${rgba colors.base00 "99"}",
    		},
    		dim_special = 0.3,
    		blur = {
    			enabled = true,
    			size = 5,
    			passes = 3,
    			vibrancy = 0.5,
    			new_optimizations = true,
    			ignore_opacity = true,
    			xray = false,
    			special = true,
    		},
    	},
    	animations = {
    		enabled = true,
    	},
    	misc = {
    		disable_hyprland_logo = true,
    		disable_splash_rendering = true,
    	},
    })

    hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
    hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
    hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
    hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

    hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
    hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
    hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
    hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
    hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
    hl.animation({ leaf = "borderangle", enabled = true, speed = 35, bezier = "liner", style = "loop" })
    hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
    hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })
    hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "wind", style = "slidevert" })
  '';
}
