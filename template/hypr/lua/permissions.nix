{
  xdg.configFile."hypr/lua/permissions.lua".text =
    /*
    Lua
    */
    ''
      hl.config({
      	ecosystem = {
      		enforce_permissions = true,
      	},
      })
      hl.permission({ binary = "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim", type = "screencopy", mode = "allow" })
      hl.permission({
      	binary = "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped",
      	type = "screencopy",
      	mode = "allow",
      })
      hl.permission({
      	binary = "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*[+]date[=][0-9]*-[0-9]*-[0-9]*_[a-z0-9]*/libexec/.xdg-desktop-portal-hyprland-wrapped",
      	type = "screencopy",
      	mode = "allow",
      })
      hl.permission({
      	binary = "/nix/store/[a-z0-9]{32}-quickshell-[0-9.]*/bin/.quickshell-wrapped",
      	type = "screencopy",
      	mode = "allow",
      })
      hl.permission({
      	binary = "/nix/store/[a-z0-9]{32}-hyprquickframe-[0-9.]*/bin/.hyprquickframe-wrapped",
      	type = "screencopy",
      	mode = "allow",
      })
      hl.permission({
      	binary = "/nix/store/[a-z0-9]{32}-hyprquickframe-[0-9.]*/bin/hyprquickframe",
      	type = "screencopy",
      	mode = "allow",
      })
      hl.permission({
      	binary = "/nix/store/[a-z0-9]{32}-hyprpicker-[0-9.]*/bin/hyprpicker",
      	type = "screencopy",
      	mode = "allow",
      })
    '';
}
