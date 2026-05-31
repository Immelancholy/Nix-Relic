{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  wayland.windowManager.hyprland = {
    sourceFirst = true;
    extraConfig =
      /*
      Lua
      */
      ''
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim", type = "screencopy", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped", type = "screencopy", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*[+]date[=][0-9]*-[0-9]*-[0-9]*_[a-z0-9]*/libexec/.xdg-desktop-portal-hyprland-wrapped", type = "screencopy", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-csgo-vulkan-fix-[0-9.]*/lib/libcsgo-vulkan-fix.so", type = "plugin", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-hyprland-easymotion/lib/libhyprland-easymotion.so", type = "plugin", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-quickshell-[0-9.]*/bin/.quickshell-wrapped", type = "screencopy", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-hyprquickframe-[0-9.]*/bin/.hyprquickframe-wrapped", type = "screencopy", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-hyprquickframe-[0-9.]*/bin/hyprquickframe", type = "screencopy", mode = "allow" })
        hl.permission({ binary = "/nix/store/[a-z0-9]{32}-hyprpicker-[0-9.]*/bin/hyprpicker", type = "screencopy", mode = "allow" })
      '';
    settings = {
      mod = {
        _var = "SUPER";
      };
      mods = {
        _var = "SUPER + SHIFT";
      };
      modc = {
        _var = "SUPER + CTRL";
      };
      moda = {
        _var = "SUPER + ALT";
      };
      scr = {
        _var = "$XDG_BIN_HOME";
      };
      term = {
        _var = "uwsm app -- kitty";
      };
      files = {
        _var = "uwsm app -- nemo.desktop";
      };
      filest = {
        _var = "uwsm app -- yazi.desktop";
      };
      menu = {
        _var = ''rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,fibrowser,power-menu:rofi-power-menu'';
      };
      browser = {
        _var = "uwsm app -- zen-beta.desktop";
      };
      playerctl = {
        _var = mkLuaInline "\"uwsm app -- playerctl --player=\" .. player";
      };
      discord = {
        _var = "uwsm app -- vesktop.desktop";
      };
      editor = {
        _var = "uwsm app -- dev.zed.Zed.desktop";
      };
      config = {
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          key_press_enables_dpms = true;
        };
        cursor = {
          hide_on_key_press = true;
        };
        ecosystem = {
          # enforce_permissions = true;
        };
      };
    };
  };
  imports = [
    ./binds.nix
    ./theme
    ./rules.nix
  ];
}
