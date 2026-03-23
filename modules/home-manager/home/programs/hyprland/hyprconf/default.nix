{
  wayland.windowManager.hyprland = {
    sourceFirst = true;
    settings = {
      "$scr" = "$XDG_BIN_HOME";
      "$term" = "uwsm app -- kitty";
      "$files" = "uwsm app -- nemo.desktop";
      "$filest" = "uwsm app -- yazi.desktop";
      "$mod" = "SUPER";
      "$mods" = "SUPERSHIFT";
      "$modc" = "SUPERCTRL";
      "$menu" = ''rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'';
      "$browser" = "uwsm app -- zen-beta.desktop";
      "$playerctl" = "uwsm app -- playerctl --player=$player";
      "$discord" = "uwsm app -- vesktop.desktop";
      "$editor" = "uwsm app -- dev.zed.Zed.desktop";
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
      permission = [
        "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim, screencopy, allow"
        "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
        "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*[+]date[=][0-9]*-[0-9]*-[0-9]*_[a-z0-9]*/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
        "/nix/store/[a-z0-9]{32}-hy3-hl[0-9.]*/lib/libhy3.so, plugin, allow"
        "/nix/store/[a-z0-9]{32}-csgo-vulkan-fix-[0-9.]*/lib/libcsgo-vulkan-fix.so, plugin, allow"
        "/nix/store/[a-z0-9]{32}-xtra-dispatchers-[0-9.]*/lib/libxtra-dispatchers.so, plugin, allow"
        "/nix/store/[a-z0-9]{32}-hyprexpo-[0-9.]*/lib/libhyprexpo.so, plugin, allow"
        "/nix/store/[a-z0-9]{32}-hyprland-easymotion/lib/libhyprland-easymotion.so, plugin, allow"
        "/nix/store/[a-z0-9]{32}-hyprquickframe-[0-9.]*/bin/.hyprquickframe-wrapped, screencopy, allow"
        "/nix/store/[a-z0-9]{32}-hyprquickframe-[0-9.]*/bin/hyprquickframe, screencopy, allow"
        "/nix/store/[a-z0-9]{32}-hyprpicker-[0-9.]*/bin/hyprpicker, screencopy, allow"
      ];
    };
  };
  imports = [
    ./binds.nix
    ./theme
    ./windowrules.nix
  ];
}
