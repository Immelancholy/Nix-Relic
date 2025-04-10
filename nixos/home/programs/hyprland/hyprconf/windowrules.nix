{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # opacity 0.90 0.90,class:^(firefox)$
      # opacity 0.90 0.90,class:^(Google-chrome)$
      # opacity 0.90 0.90,class:^(Brave-browser)$
      ''opacity 0.90 0.90,class:^(zen-beta)$''
      ''opacity 1.0 override, title:(.*YouTube.*|.*Instagram.*)$''
      ''opacity 0.80 0.80,class:^(gcr-prompter)$''
      ''opacity 0.80 0.80,class:^(org.gnome.seahorse.Application)$''
      ''opacity 0.80 0.80,class:^(org.prismlauncher.PrismLauncher)$''
      ''opacity 0.80 0.80,class:^(code-oss)$''
      ''opacity 0.80 0.80,class:^([Cc]ode)$''
      ''opacity 0.80 0.80,class:^(code-url-handler)$''
      ''opacity 0.80 0.80,class:^(code-insiders-url-handler)$''
      ''opacity 0.80 0.80,class:^(org.kde.dolphin)$''
      ''opacity 0.80 0.80,class:^(org.kde.ark)$''
      ''opacity 0.80 0.80,class:^(nwg-look)$''
      ''opacity 0.80 0.80,class:^(qt5ct)$''
      ''opacity 0.80 0.80,class:^(qt6ct)$''
      ''opacity 0.90 0.90,class:^(obsidian)$''
      ''opacity 0.80 0.80,class:^(kvantummanager)$''
      ''opacity 0.90 0.80,class:^(org.pulseaudio.pavucontrol)$''
      ''opacity 0.80 0.70,class:^(blueman-manager)$''
      ''opacity 0.80 0.70,class:^(nm-applet)$''
      ''opacity 0.80 0.70,class:^(nm-connection-editor)$''
      ''opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$''
      ''opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$''
      ''opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$''
      ''opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$''
      ''opacity 0.70 0.70,class:^([Ss]team)$''
      ''opacity 0.70 0.70,class:^(steamwebhelper)$''
      ''opacity 0.70 0.70,class:^([Ss]potify)$''
      ''opacity 0.70 0.70,initialTitle:^(Spotify Free)$''
      ''opacity 0.70 0.70,initialTitle:^(Spotify Premium)$''
      ''opacity 0.80 0.80,class:^(nemo)$''
      ''opacity 0.80 0.80,class:^(org.gnome.Terminal)$''

      ''opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$'' # Clapper-Gtk
      ''opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$'' # Flatseal-Gtk
      ''opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$'' # Cartridges-Gtk
      ''opacity 0.80 0.80,class:^(com.obsproject.Studio)$'' # Obs-Qt
      ''opacity 0.80 0.80,class:^(gnome-boxes)$'' # Boxes-Gtk
      ''opacity 0.90 0.90,class:^(vesktop)$'' # Vesktop
      ''opacity 0.90 0.90,class:^(discord)$'' # Discord-Electron
      ''opacity 0.80 0.80,class:^(WebCord)$'' # WebCord-Electron
      ''opacity 0.80 0.80,class:^(ArmCord)$'' # ArmCord-Electron
      ''opacity 0.80 0.80,class:^(app.drey.Warp)$'' # Warp-Gtk
      ''opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$'' # ProtonUp-Qt
      ''opacity 0.80 0.80,class:^(yad)$'' # Protontricks-Gtk
      ''opacity 0.80 0.80,class:^(Signal)$'' # Signal-Gtk
      ''opacity 0.80 0.80,class:^(io.github.alainm23.planify)$'' # planify-Gtk
      ''opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$'' # Upscaler-Gtk
      ''opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$'' # VideoDownloader-Gtk
      ''opacity 0.80 0.80,class:^(io.gitlab.adhami3310.Impression)$'' # Impression-Gtk
      ''opacity 0.80 0.80,class:^(io.missioncenter.MissionCenter)$'' # MissionCenter-Gtk
      ''opacity 0.80 0.80,class:^(io.github.flattool.Warehouse)$'' # Warehouse-Gtk

      ''float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$''
      ''float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$''
      ''float,title:^(About Mozilla Firefox)$''
      ''float,title:^(Picture-in-Picture)$''
      ''float,class:^(firefox)$,title:^(Library)$''
      ''float,class:^(kitty)$,title:^(top)$''
      ''float,class:^(kitty)$,title:^(btop)$''
      ''float,class:^(kitty)$,title:^(htop)$''
      ''float,class:^(vlc)$''
      ''float,class:^(kvantummanager)$''
      ''float,class:^(qt5ct)$''
      ''float,class:^(qt6ct)$''
      ''float,class:^(nwg-look)$''
      ''float,class:^(org.kde.ark)$''
      ''float,class:^(org.pulseaudio.pavucontrol)$''
      ''float,class:^(blueman-manager)$''
      ''float,class:^(nm-applet)$''
      ''float,class:^(nm-connection-editor)$''
      ''float,class:^(org.kde.polkit-kde-authentication-agent-1)$''

      ''float,class:^(Signal)$'' # Signal-Gtk
      ''float,class:^(com.github.rafostar.Clapper)$'' # Clapper-Gtk
      ''float,class:^(app.drey.Warp)$'' # Warp-Gtk
      ''float,class:^(net.davidotek.pupgui2)$'' # ProtonUp-Qt
      ''float,class:^(yad)$'' # Protontricks-Gtk
      ''float,class:^(org.gnome.Loupe)$'' # Imageviewer-Gtk
      ''float,class:^(io.github.alainm23.planify)$'' # planify-Gtk
      ''float,class:^(io.gitlab.theevilskeleton.Upscaler)$'' # Upscaler-Gtk
      ''float,class:^(com.github.unrud.VideoDownloader)$'' # VideoDownloader-Gkk
      ''float,class:^(io.gitlab.adhami3310.Impression)$'' # Impression-Gtk
      ''float,class:^(io.missioncenter.MissionCenter)$'' # MissionCenter-Gtk
      ''float,title:^(Friends List)$''
      ''float,title:^(Steam Settings)$''

      ''opacity 0.90 0.90,class:^(org.rncbc.qpwgraph)$''
      ''opacity 0.90 0.90,class:^(com.github.wwmm.easyeffects)$''

      ''float,title:^(rmpc)$''
      ''size 900 580,title:^(rmpc)$''
      ''move 70 235,title:^(rmpc)$''

      ''workspace 3 silent, class:^(vesktop)$''
      ''workspace 4 silent, class:^(org.rncbc.qpwgraph)$''

      ''float,title:^(cava)$''
      ''size 840 672,title:^(cava)$''
      ''move 1015 188,title:^(cava)$''
      ''nodim, title:^(cava)$''

      ''float,title:^(btop)$''
      ''size 960 675,title:^(btop)$''

      ''size 437 306, title:^(Qalculate!)$''
      ''float, title:^(Qalculate!)$''
      ''opacity 0.80 0.80, title:^(Qalculate!)$''

      ''size 850 540,class:^(org.pulseaudio.pavucontrol)$''

      # noblur, class:^(kitty)$

      # common modals
      ''float,title:^(Open)$''
      ''float,title:^(Choose Files)$''
      ''float,title:^(Save As)$''
      ''float,title:^(Confirm to replace files)$''
      ''float,title:^(File Operation Progress)$''
      ''float,class:^(xdg-desktop-portal-gtk)$''
      ''float,title:^(MainPicker)$''
      ''opacity 0.80 0.80,class:^(xdg-desktop-portal-gtk)$''
      ''opacity 0.80 0.80,title:^(MainPicker)$''
      ''opacity 0.90 0.80,title:^(File Upload)$''
      ''opacity 0.80 0.70,title:^(Hyprland Polkit Agent)$''
      ''opacity 0.90 0.90,class:^(.blueman-manager-wrapped)$''
      ''float,class:^(.blueman-manager-wrapped)$''
      ''opacity 0.90 0.90,class:^(solaar)$''
      ''float,class:^(solaar)$''
    ];
    layerrule = [
      "blur,rofi"
      "ignorezero,rofi"
      "blur,notifications"
      "ignorezero,notifications"
      "blur,swaync-notification-window"
      "ignorezero,swaync-notification-window"
      "blur,swaync-control-center"
      "ignorezero,swaync-control-center"
      "blur,logout_dialog"
    ];
  };
}
