{lib, ...}: let
  inherit (lib.generators) mkLuaInLine;
in {
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        match.class = "^(.*)$";
        opacity = "0.8 0.7";
      }
      {
        match.class = "^(kitty)$";
        opacity = "1.0 override 0.9 override";
      }
      {
        match = {
          class = "^(zen.*)$";
        };
        opacity = "1.0 override 0.9 override";
      }
      {
        match = {
          class = "^(zen.*)$";
          title = "^(Library)$";
        };
        opacity = "1.0 override 0.9 override";
        float = true;
      }
      {
        match.class = "^(com.saivert.pwvucontrol)$";
        opacity = "0.9 override 0.7 override";
        float = true;
        size = "850 540";
      }
      {
        match.class = "^(obsidian)$";
        opacity = "0.9 override 0.7 override";
      }
      {
        match.class = "^(vesktop)$";
        opacity = "0.9 override 0.7 override";
        workspace = "3 silent";
      }
      {
        match.class = "^(discord)$";
        opacity = "0.9 override 0.7 override";
        workspace = "3 silent";
      }
      {
        match.class = "^(WebCord)$";
        opacity = "0.9 override 0.7 override";
        workspace = "3 silent";
      }
      {
        match.class = "^(ArmCord)$";
        opacity = "0.9 override 0.7 override";
        workspace = "3 silent";
      }
      {
        match.class = "^(org.rncbc.qpwgraph)$";
        workspace = "4 silent";
      }
      {
        match.class = "^(com.github.wwmm.easyeffects)$";
        float = true;
        opacity = "0.9 override 0.8 override";
      }
      {
        match.class = "^(dev.zed.Zed.*)$";
        opacity = "0.9 override 0.8 override";
      }
      {
        match.class = "^(vlc)$";
        float = true;
      }
      {
        match.class = "^(solaar)$";
        float = true;
      }
      {
        match.class = "^(kvantummanager)$";
        float = true;
      }
      {
        match.class = "^(qt5ct)$";
        float = true;
      }
      {
        match.class = "^(qt6ct)$";
        float = true;
      }
      {
        match.class = "^(org.kde.ark)$";
        float = true;
      }
      {
        match.class = "^(blueman-manager)$";
        float = true;
      }
      {
        match.class = "^(nm-applet)$";
        float = true;
      }
      {
        match.class = "^(nm-connection-editor)$";
        float = true;
      }
      {
        match.class = "^(org.kde.polkit-kde-authentication-agent-1)$";
        float = true;
      }
      {
        match.class = "^(Signal)$";
        float = true;
      }
      {
        match.class = "^(com.vysp3r.ProtonPlus)$";
        float = true;
      }
      {
        match.class = "^(yad)$";
        float = true;
      }
      {
        match.class = "^(xdg-desktop-portal-gtk)$";
        float = true;
      }
      {
        match.class = "^(org.gnome.Loupe)$";
        float = true;
      }
      {
        match.class = "^(mpv)$";
        float = true;
      }
      {
        match.class = "^(com.gabm.satty)$";
        float = true;
      }
      {
        match.class = "^(update-system)$";
        float = true;
        opacit = "1.0 override 0.9 override";
        size = "590 775";
        move = "1305 42";
      }
      {
        match = {
          class = "^(kitty)$";
          title = "^(btop)";
        };
        float = true;
        size = "960 675";
      }
      {
        match.title = "^(LocalSend)$";
        float = true;
      }
      {
        match.title = "^(About Mozilla Firefox)$";
        float = true;
      }
      {
        match.title = "^(Picture-in-Picture)$";
        float = true;
      }
      {
        match.title = "^(Friends List)$";
        float = true;
      }
      {
        match.title = "^(Steam Settings)$";
        float = true;
      }
      {
        match.title = "^(Qalculate!)$";
        float = true;
        size = "437 306";
      }
      {
        match.title = "^(.*Properties*.)$";
        float = true;
        size = "437 306";
      }
      {
        match.title = "^(Open)$";
        float = true;
      }
      {
        match.title = "^(Choose Files)$";
        float = true;
      }
      {
        match.title = "^(Save As)$";
        float = true;
      }
      {
        match.title = "^(Confirm to replace files)$";
        float = true;
      }
      {
        match.title = "^(File Operation Progress)$";
        float = true;
      }
      {
        match.title = "^(MainPicker)$";
        float = true;
      }
      {
        match.title = "^(Select what to share)$";
        float = true;
      }
    ];

    layerrule = [
      {
        match.namespace = "rofi";
        blur = true;
        ignore_alpha = 0;
      }
      {
        match.namespace = "notifications";
        blur = true;
        ignore_alpha = 0;
      }
      {
        match.namespace = "waybar";
        blur = true;
      }
      {
        match.namespace = "hyprpicker";
        no_anim = true;
      }
      {
        match.namespace = "selection";
        no_anim = true;
      }
    ];
  };
}
