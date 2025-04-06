{
  wayland.windowManager.hyprland.extraConfig = ''
        # windowrule = opacity 0.90 0.90,class:^(firefox)$
        # windowrule = opacity 0.90 0.90,class:^(Google-chrome)$
        # windowrule = opacity 0.90 0.90,class:^(Brave-browser)$
        windowrule = opacity 0.90 0.90,class:^(zen-beta)$
        windowrule = opacity 1.0 override, title:(.*YouTube.*|.*Instagram.*)$
        windowrule = opacity 0.80 0.80,class:^(gcr-prompter)$
        windowrule = opacity 0.80 0.80,class:^(org.gnome.seahorse.Application)$
        windowrule = opacity 0.80 0.80,class:^(org.prismlauncher.PrismLauncher)$
        windowrule = opacity 0.80 0.80,class:^(code-oss)$
        windowrule = opacity 0.80 0.80,class:^([Cc]ode)$
        windowrule = opacity 0.80 0.80,class:^(code-url-handler)$
        windowrule = opacity 0.80 0.80,class:^(code-insiders-url-handler)$
        windowrule = opacity 0.80 0.80,class:^(org.kde.dolphin)$
        windowrule = opacity 0.80 0.80,class:^(org.kde.ark)$
        windowrule = opacity 0.80 0.80,class:^(nwg-look)$
        windowrule = opacity 0.80 0.80,class:^(qt5ct)$
        windowrule = opacity 0.80 0.80,class:^(qt6ct)$
        windowrule = opacity 0.90 0.90,class:^(obsidian)$
        windowrule = opacity 0.80 0.80,class:^(kvantummanager)$
        windowrule = opacity 0.90 0.80,class:^(org.pulseaudio.pavucontrol)$
        windowrule = opacity 0.80 0.70,class:^(blueman-manager)$
        windowrule = opacity 0.80 0.70,class:^(nm-applet)$
        windowrule = opacity 0.80 0.70,class:^(nm-connection-editor)$
        windowrule = opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$
        windowrule = opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$
        windowrule = opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$
        windowrule = opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$
        windowrule = opacity 0.70 0.70,class:^([Ss]team)$
        windowrule = opacity 0.70 0.70,class:^(steamwebhelper)$
        windowrule = opacity 0.70 0.70,class:^([Ss]potify)$
        windowrule = opacity 0.70 0.70,initialTitle:^(Spotify Free)$
        windowrule = opacity 0.70 0.70,initialTitle:^(Spotify Premium)$
        windowrule = opacity 0.80 0.80,class:^(nemo)$
        windowrule = opacity 0.80 0.80,class:^(org.gnome.Terminal)$

        windowrule = opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$ # Clapper-Gtk
        windowrule = opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$ # Flatseal-Gtk
        windowrule = opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$ # Cartridges-Gtk
        windowrule = opacity 0.80 0.80,class:^(com.obsproject.Studio)$ # Obs-Qt
        windowrule = opacity 0.80 0.80,class:^(gnome-boxes)$ # Boxes-Gtk
        windowrule = opacity 0.90 0.90,class:^(vesktop)$ # Vesktop
        windowrule = opacity 0.90 0.90,class:^(discord)$ # Discord-Electron
        windowrule = opacity 0.80 0.80,class:^(WebCord)$ # WebCord-Electron
        windowrule = opacity 0.80 0.80,class:^(ArmCord)$ # ArmCord-Electron
        windowrule = opacity 0.80 0.80,class:^(app.drey.Warp)$ # Warp-Gtk
        windowrule = opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$ # ProtonUp-Qt
        windowrule = opacity 0.80 0.80,class:^(yad)$ # Protontricks-Gtk
        windowrule = opacity 0.80 0.80,class:^(Signal)$ # Signal-Gtk
        windowrule = opacity 0.80 0.80,class:^(io.github.alainm23.planify)$ # planify-Gtk
        windowrule = opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$ # Upscaler-Gtk
        windowrule = opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$ # VideoDownloader-Gtk
        windowrule = opacity 0.80 0.80,class:^(io.gitlab.adhami3310.Impression)$ # Impression-Gtk
        windowrule = opacity 0.80 0.80,class:^(io.missioncenter.MissionCenter)$ # MissionCenter-Gtk
        windowrule = opacity 0.80 0.80,class:^(io.github.flattool.Warehouse)$ # Warehouse-Gtk

        windowrule = float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$
        windowrule = float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$
        windowrule = float,title:^(About Mozilla Firefox)$
        windowrule = float,class:^(firefox)$,title:^(Picture-in-Picture)$
        windowrule = float,class:^(firefox)$,title:^(Library)$
        windowrule = float,class:^(kitty)$,title:^(top)$
        windowrule = float,class:^(kitty)$,title:^(btop)$
        windowrule = float,class:^(kitty)$,title:^(htop)$
        windowrule = float,class:^(vlc)$
        windowrule = float,class:^(kvantummanager)$
        windowrule = float,class:^(qt5ct)$
        windowrule = float,class:^(qt6ct)$
        windowrule = float,class:^(nwg-look)$
        windowrule = float,class:^(org.kde.ark)$
        windowrule = float,class:^(org.pulseaudio.pavucontrol)$
        windowrule = float,class:^(blueman-manager)$
        windowrule = float,class:^(nm-applet)$
        windowrule = float,class:^(nm-connection-editor)$
        windowrule = float,class:^(org.kde.polkit-kde-authentication-agent-1)$

        windowrule = float,class:^(Signal)$ # Signal-Gtk
        windowrule = float,class:^(com.github.rafostar.Clapper)$ # Clapper-Gtk
        windowrule = float,class:^(app.drey.Warp)$ # Warp-Gtk
        windowrule = float,class:^(net.davidotek.pupgui2)$ # ProtonUp-Qt
        windowrule = float,class:^(yad)$ # Protontricks-Gtk
        windowrule = float,class:^(org.gnome.Loupe)$ # Imageviewer-Gtk
        windowrule = float,class:^(io.github.alainm23.planify)$ # planify-Gtk
        windowrule = float,class:^(io.gitlab.theevilskeleton.Upscaler)$ # Upscaler-Gtk
        windowrule = float,class:^(com.github.unrud.VideoDownloader)$ # VideoDownloader-Gkk
        windowrule = float,class:^(io.gitlab.adhami3310.Impression)$ # Impression-Gtk
        windowrule = float,class:^(io.missioncenter.MissionCenter)$ # MissionCenter-Gtk
        windowrule = float,title:^(Friends List)$
        windowrule = float,title:^(Steam Settings)$

        windowrule = opacity 0.90 0.90,class:^(org.rncbc.qpwgraph)$
        windowrule = opacity 0.90 0.90,class:^(com.github.wwmm.easyeffects)$

        windowrule = float,title:^(rmpc)$
        windowrule = size 900 580,title:^(rmpc)$
        windowrule = move 70 235,title:^(rmpc)$

        windowrule = workspace 3 silent, class:^(vesktop)$

        windowrule = float,title:^(cava)$
        windowrule = size 840 672,title:^(cava)$
        windowrule = move 1015 188,title:^(cava)$
        windowrule = nodim, title:^(cava)$

        windowrule = float,title:^(btop)$
        windowrule = size 960 675,title:^(btop)$

        windowrule = size 437 306, title:^(Qalculate!)$
        windowrule = float, title:^(Qalculate!)$
        windowrule = opacity 0.80 0.80, title:^(Qalculate!)$

        windowrule = opacity 0.80 0.80,class:^(dev.zed.Zed-Dev)$
        windowrule = size 850 540,class:^(org.pulseaudio.pavucontrol)$

        # windowrule = noblur, class:^(kitty)$

    # common modals
        windowrule = float,title:^(Open)$
        windowrule = float,title:^(Choose Files)$
        windowrule = float,title:^(Save As)$
        windowrule = float,title:^(Confirm to replace files)$
        windowrule = float,title:^(File Operation Progress)$
        windowrule = float,class:^(xdg-desktop-portal-gtk)$
        windowrule = float,title:^(MainPicker)$
        windowrule = opacity 0.80 0.80,class:^(xdg-desktop-portal-gtk)$
        windowrule = opacity 0.80 0.80,title:^(MainPicker)$
        windowrule = opacity 0.90 0.80,title:^(File Upload)$
        windowrule = opacity 0.80 0.70,title:^(Hyprland Polkit Agent)$

        layerrule = blur,rofi
        layerrule = ignorezero,rofi
        layerrule = blur,notifications
        layerrule = ignorezero,notifications
        layerrule = blur,swaync-notification-window
        layerrule = ignorezero,swaync-notification-window
        layerrule = blur,swaync-control-center
        layerrule = ignorezero,swaync-control-center
        layerrule = blur,logout_dialog
  '';
}
