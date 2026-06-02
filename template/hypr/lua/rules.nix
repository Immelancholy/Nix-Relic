{
  xdg.configFile."hypr/lua/rules.lua".text = /* lua */ ''
    hl.window_rule({
    	match = {
    		class = "^(.*)$",
    	},
    	opacity = "0.8 0.7",
    })
    hl.window_rule({
    	match = {
    		class = "^(steam_app_\\d+)$",
    	},
    	workspace = "special:game",
    	fullscreen = true,
    })
    hl.window_rule({
    	match = {
    		xdg_tag = "^(proton-game)$",
    	},
    	workspace = "special:game",
    	fullscreen = true,
    })
    hl.window_rule({
    	match = {
    		content = "game",
    	},
    	workspace = "special:game",
    	fullscreen = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(xfreerdp)$",
    	},
    	workspace = "special:win",
    	fullscreen = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(.*[Ee]pisode \\d+ - mpv*.)$",
    	},
        workspace = "special:video",
        opacity = "1.0 override 0.8 override",
    	fullscreen = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(kitty)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(mpd)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(neo)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(fastfetch)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(cava)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(btop)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(zen.*)$",
    	},
    	opacity = "1.0 override 0.9 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(zen.*)$",
    		title = "^(Library)$",
    	},
    	opacity = "1.0 override 0.9 override",
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(com.saivert.pwvucontrol)$",
    	},
    	opacity = "0.9 override 0.7 override",
    	float = true,
    	size = { 850, 540 },
    })
    hl.window_rule({
    	match = {
    		class = "^(obsidian)$",
    	},
    	opacity = "0.9 override 0.7 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(vesktop)$",
    	},
    	opacity = "0.9 override 0.7 override",
    	workspace = "3 silent",
    })
    hl.window_rule({
    	match = {
    		class = "^(discord)$",
    	},
    	opacity = "0.9 override 0.7 override",
    	workspace = "3 silent",
    })
    hl.window_rule({
    	match = {
    		class = "^(WebCord)$",
    	},
    	opacity = "0.9 override 0.7 override",
    	workspace = "3 silent",
    })
    hl.window_rule({
    	match = {
    		class = "^(ArmCord)$",
    	},
    	opacity = "0.9 override 0.7 override",
    	workspace = "3 silent",
    })
    hl.window_rule({
    	match = {
    		class = "^(org.rncbc.qpwgraph)$",
    	},
    	workspace = "4 silent",
    })
    hl.window_rule({
    	match = {
    		class = "^(com.github.wwmm.easyeffects)$",
    	},
    	float = true,
    	opacity = "0.9 override 0.8 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(org.kde.easyeffects)$",
    	},
    	float = true,
    	opacity = "0.9 override 0.8 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(dev.zed.Zed.*)$",
    	},
    	opacity = "0.9 override 0.8 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(vlc)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(solaar)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(kvantummanager)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(qt5ct)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(qt6ct)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(org.kde.ark)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(blueman-manager)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(nm-applet)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(nm-connection-editor)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(org.kde.polkit-kde-authentication-agent-1)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(Signal)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(com.vysp3r.ProtonPlus)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(yad)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(xdg-desktop-portal-gtk)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(org.gnome.Loupe)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(mpv)$",
    	},
    	float = true,
        opacity = "1.0 override 0.8 override",
    })
    hl.window_rule({
    	match = {
    		class = "^(com.gabm.satty)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		class = "^(update-system)$",
    	},
    	float = true,
    	opacity = "1.0 override 0.9 override",
    	size = { 590, 775 },
    	move = { 1305, 42 },
    })
    hl.window_rule({
    	match = {
    		class = "^(kitty)$",
    		title = "^(btop)",
    	},
    	float = true,
    	size = { 960, 675 },
    })
    hl.window_rule({
    	match = {
    		title = "^(LocalSend)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(About Mozilla Firefox)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Picture-in-Picture)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Friends List)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Steam Settings)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Qalculate!)$",
    	},
    	float = true,
    	size = { 437, 306 },
    })
    hl.window_rule({
    	match = {
    		title = "^(.*Properties*.)$",
    	},
    	float = true,
    	size = { 437, 306 },
    })
    hl.window_rule({
    	match = {
    		title = "^(Open)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Choose Files)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Save As)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Confirm to replace files)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(File Operation Progress)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(MainPicker)$",
    	},
    	float = true,
    })
    hl.window_rule({
    	match = {
    		title = "^(Select what to share)$",
    	},
    	float = true,
    })
    hl.layer_rule({
    	match = { namespace = "waybar" },
    	blur = true,
    })
    hl.layer_rule({
    	match = { namespace = "rofi" },
    	blur = true,
    	ignore_alpha = 0,
    })
    hl.layer_rule({
    	match = { namespace = "hyprpicker" },
    	no_anim = true,
    })
    hl.layer_rule({
    	match = { namespace = "selection" },
    	no_anim = true,
    })
    hl.layer_rule({
    	match = { namespace = "notifications" },
    	blur = true,
    	ignore_alpha = 0,
    })
  '';
}
