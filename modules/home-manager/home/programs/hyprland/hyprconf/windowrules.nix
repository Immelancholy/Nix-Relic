{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      ''match:class ^(dev.zed.Zed-Nightly)$, opacity 0.90 0.80''
      ''match:class ^(dev.zed.Zed)$, opacity 0.90 0.80''
      ''match:class ^(solaar)$, opacity 0.90 0.80''
      ''match:class ^(neo)$, opacity 1.0 0.90''
      ''match:class ^(cava)$, opacity 1.0 0.90''
      ''match:class ^(mpd)$, opacity 1.0 0.90''
      ''match:class ^(btop)$, opacity 1.0 0.90''
      ''match:class ^(fastfetch)$, opacity 1.0 0.90''
      ''match:class ^(kitty)$, opacity 1.0 0.90''
      ''match:class ^(zen)$, opacity 1.0 0.90''
      ''match:class ^(zen-beta)$, opacity 1.0 0.90''
      ''match:class ^(gcr-prompter)$, opacity 0.80 0.70''
      ''match:class ^(org.gnome.seahorse.Application)$, opacity 0.80 0.70''
      ''match:class ^(org.prismlauncher.PrismLauncher)$, opacity 0.80 0.70''
      ''match:class ^(code-oss)$, opacity 0.80 0.70''
      ''match:class ^([Cc]ode)$, opacity 0.80 0.70''
      ''match:class ^(code-url-handler)$, opacity 0.80 0.70''
      ''match:class ^(code-insiders-url-handler)$, opacity 0.80 0.70''
      ''match:class ^(org.kde.dolphin)$, opacity 0.80 0.70''
      ''match:class ^(org.kde.ark)$, opacity 0.80 0.70''
      ''match:class ^(nwg-look)$, opacity 0.80 0.70''
      ''match:class ^(qt5ct)$, opacity 0.80 0.70''
      ''match:class ^(qt6ct)$, opacity 0.80 0.70''
      ''match:class ^(obsidian)$, opacity 0.90 0.70''
      ''match:class ^(kvantummanager)$, opacity 0.80 0.70''
      ''match:class ^(com.saivert.pwvucontrol)$, opacity 0.90 0.70''
      ''match:class ^(blueman-manager)$, opacity 0.80 0.70''
      ''match:class ^(nm-applet)$, opacity 0.80 0.70''
      ''match:class ^(nm-connection-editor)$, opacity 0.80 0.70''
      ''match:class ^(org.polkit-kde-authentication-agent-1)$, opacity 0.80 0.70''
      ''match:class ^(polkit-gnome-authentication-agent-1)$, opacity 0.80 0.70''
      ''match:class ^(org.freedesktop.impl.portal.desktop.gtk)$, opacity 0.80 0.70''
      ''match:class ^(org.freedesktop.impl.portal.desktop.hyprland)$, opacity 0.80 0.70''
      ''match:class ^([Ss]team)$, opacity 0.70 0.70''
      ''match:class ^(steamwebhelper)$, opacity 0.70 0.70,''
      ''match:class ^([Ss]potify)$, opacity 0.70 0.70''
      ''match:class ^(nemo)$, opacity 0.80 0.70''
      ''match:class ^(org.gnome.Terminal)$, opacity 0.80 0.70''

      ''match:class ^(com.github.rafostar.Clapper)$, opacity 0.90 0.80'' # Clapper-Gtk
      ''match:class ^(com.github.tchx84.Flatseal)$, opacity 0.80 0.70'' # Flatseal-Gtk
      ''match:class ^(hu.kramo.Cartridges)$, opacity 0.80 0.70'' # Cartridges-Gtk
      ''match:class ^(com.obsproject.studio)$, opacity 0.80 0.70'' # Obs-Qt
      ''match:class ^(gnome-boxes)$, opacity 0.80 0.70'' # Boxes-Gtk
      ''match:class ^(vesktop)$, opacity 0.90 0.80'' # Vesktop
      ''match:class ^(discord)$, opacity 0.90 0.80'' # Discord-Electron
      ''match:class ^(WebCord)$, opacity 0.90 0.80'' # WebCord-Electron
      ''match:class ^(ArmCord)$, opacity 0.80 0.70'' # ArmCord-Electron
      ''match:class ^(app.drey.Warp)$, opacity 0.80 0.70'' # Warp-Gtk
      ''match:class ^(net.davidotek.pupgui2)$, opacity 0.80 0.70'' # ProtonUp-Qt
      ''match:class ^(yad)$, opacity 0.80 0.70'' # Protontricks-Gtk
      ''match:class ^(Signal)$, opacity 0.80 0.70'' # Signal-Gtk
      ''match:class ^(io.github.alainm23.planify)$, opacity 0.80 0.70'' # planify-Gtk
      ''match:class ^(io.github.theevilskeleton.Upscaler)$, opacity 0.80 0.70'' # Upscaler-Gtk
      ''match:class ^(com.github.unrud.VideoDownloader)$, opacity 0.80 0.70'' # VideoDownloader-Gtk
      ''match:class ^(io.github.adhami3310.Impression)$, opacity 0.80 0.70'' # Impression-Gtk
      ''match:class ^(io.missioncenter.MissionCenter)$, opacity 0.80 0.70'' # MissionCenter-Gtk
      ''match:class ^(io.github.flattool.Warehouse)$, opacity 0.80 0.70'' # Warehouse-Gtk

      ''match:class ^(vlc)$, float on''
      ''match:class ^(solaar)$, float on''
      ''match:class ^(kvantummanager)$ float on''
      ''match:class ^(qt5ct)$, float on''
      ''match:class ^(qt6ct)$, float on''
      ''match:class ^(nwg-look)$, float on''
      ''match:class ^(org.kde.ark)$, float on''
      ''match:class ^(com.saivert.pwvucontrol)$, float on''
      ''match:class ^(blueman-manager)$, float on''
      ''match:class ^(nm-applet)$, float on''
      ''match:class ^(nm-connection-editor)$, float on''
      ''match:class ^(org.kde.polkit-kde-authentication-agent-1)$, float on''
      ''match:class ^(Signal)$, float on'' # Signal-Gtk
      ''match:class ^(com.github.rafostar.Clapper)$, float on'' # Clapper-Gtk
      ''match:class ^(app.drey.warp)$, float on'' # Warp-Gtk
      ''match:class ^(net.davidotek.pupgui2)$, float on'' # ProtonUp-Qt
      ''match:class ^(yad)$, float on'' # Protontricks-Gtk
      ''match:class ^(org.gnome.Loupe)$, float on'' # Imageviewer-Gtk
      ''match:class ^(io.github.alainm23.planify)$, float on'' # planify-Gtk
      ''match:class ^(io.github.theevilskeleton.Upscaler)$, float on'' # Upscaler-Gtk
      ''match:class ^(com.github.unrud.VideoDownloader)$, float on'' # VideoDownloader-Gkk
      ''match:class ^(io.github/adhami3310.Impression)$, float on'' # Impression-Gtk
      ''match:class ^(io.missioncenter.MissionCenter)$, float on'' # MissionCenter-Gtk
      ''match:class ^(org.rncbc.qpwgraph)$, opacity 0.90 0.80''
      ''match:class ^(com.github.wwmm.easyeffects)$, opacity 0.90 0.80''
      ''match:class ^(vesktop)$, workspace 3 silent''
      ''match:class ^(org.rncbc.qpwgraph)$, workspace 4 silent''
      ''match:class ^(mpv)$, float on''
      ''match:class ^(btop.ghostty)$, float on''
      ''match:class ^(btop.ghostty)$, size 960 675''
      ''match:class ^(com.saivert.pwvucontrol)$, size 850 540''

      ''match:class ^(org.kde.dolphin)$, match:title ^(Progress Dialog - Dolphin)$, float on''
      ''match:class ^(org.kde.dolphin)$, match:title ^(Copying - Dolphin)$, float on''
      ''match:class ^(firefox)$, match:title ^(Library)$, float on''
      ''match:class ^(com.github.wwmm.easyeffects)$, float on''

      ''match:class ^(update-system)$, float on''
      ''match:class ^(update-system)$, opacity 1.0 0.90''
      ''match:class ^(update-system)$, size 590 775''
      ''match:class ^(update-system)$, move 1305 42''

      ''match:class ^(kitty)$, match:title ^(btop)$, float on''
      ''match:class ^(kitty)$, match:title ^(btop)$, float on''
      ''match:class ^(kitty)$, match:title ^(htop)$, float on''
      ''match:class ^(kitty)$, match:title ^(btop)$, size 960 675''

      ''match:title ^(LocalSend)$, opacity 0.80 0.70''
      ''match:title ^(About Mozilla Firefox)$, float on''
      ''match:title ^(Picture-in-Picture)$, float on''
      ''match:title ^(Friends List)$, float on''
      ''match:title ^(Steam Settings)$, float on''
      ''match:title ^(Qalculate!)$, size 437 306$''
      ''match:title ^(Qalculate!)$, float on''
      ''match:title ^(Qalculate!)$, float on''
      ''match:title ^(Qalculate!)$, opacity 0.80 0.70''
      ''match:title ^(cava)$, float on''
      ''match:title ^(cava)$, size 840 672''
      ''match:title ^(cava)$, move 1015 188''
      ''match:title ^(rmpc)$, float on''
      ''match:title ^(rmpc)$, size 900 580''
      ''match:title ^(rmpc)$, move 70 23''
      ''match:title ^(.*Properties*.)$, float on''
      ''match:title ^(Settings — Easy Effects)$, float on''

      ''match:initial_title ^(Spotify Free)$, opacity 0.70 0.70''
      ''match:initial_title ^(Spotify Premium)$, opacity 0.70 0.70''

      # common modals
      ''match:class ^(.blueman-manager-wrapped)$, opacity 0.90 0.80''
      ''match:class ^(xdg-desktop-portal-gtk)$, opacity 0.80 0.70''
      ''match:class ^(xdg-desktop-portal-gtk)$, float on''
      ''match:class ^(.blueman-manager-wrapped)$, float on''

      ''match:title ^(MainPicker)$, opacity 0.80 0.70''
      ''match:title ^(File Upload)$, opacity 0.90 0.80''
      ''match:title ^(Hyprland Polkit Agent)$, opacity 0.80 0.70''
      ''match:title ^(Select what to share)$, opacity 0.90 0.80''
      ''match:title ^(Open)$, float on''
      ''match:title ^(Choose Files)$, float on''
      ''match:title ^(Save As)$, float on''
      ''match:title ^(Confirm to replace files)$, float on''
      ''match:title ^(File Operation Progress)$, float on''
      ''match:title ^(MainPicker)$, float on''
      ''match:title ^(Select what to share)$, float on''
    ];
    layerrule = [
      "match:namespace rofi, blur on"
      "match:namespace rofi, ignore_alpha 0"
      "match:namespace notifications, blur on"
      "match:namespace notifications, ignore_alpha 0"
      "match:namespace waybar, blur on"
      "match:namespace hyprpicker, no_anim on"
      "match:namespace selection, no_anim on"
    ];
  };
}
