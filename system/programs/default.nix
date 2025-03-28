{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./pipewire.nix
    ./sddm.nix
    ./flatpak.nix
    ./weylus.nix
    ./bluetooth.nix
  ];

  programs.xfconf.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.dconf.enable = true;

  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };

  # systemd.user.services.mpdchck = {
  #   name = "MPD Play Checker";
  #   description = "Checks if mpd is playing and runs a script to change samplerate";
  #   enable = true;
  #   # wantedBy = ["default.target"];
  #   wantedBy = ["graphical-session.target"];
  #   serviceConfig = {
  #     Type = "exec";
  #   };
  #   path = [
  #     # "/run/current-system/sw"
  #     "/home/${user}/.local/share"
  #     pkgs.uwsm
  #     pkgs.bash
  #     pkgs.mpc
  #     pkgs.pipewire
  #     pkgs.qpwgraph
  #     pkgs.procps
  #     inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  #   ];
  #   script = ''
  #     /home/${user}/.local/share/bin/mpdchck.sh
  #   '';
  #   environment = {
  #     MPD_HOST = "/run/user/1000/mpd/socket";
  #   };
  #   after = ["pipewire.service"];
  # };

  programs.zsh.enable = true;
  services.dbus = {
    enable = true;
    apparmor = "enabled";
    implementation = "broker";
  };
  environment.systemPackages = with pkgs; [
    mpc
    ffmpegthumbnailer
    libcamera
    mpvpaper
    # (ffmpeg-full.override {
    #   withUnfree = true;
    #   withOpengl = true;
    #   withRtmp = true;
    #   # withNvcodec = true;
    #   # withCuda = true;
    #   # withGPL = true;
    #   # withVaapi = true;
    #   # withVdpau = true;
    # })
    (ffmpeg-full.override {
      withUnfree = true;
      withOpengl = true;
      withRtmp = true;
    })
    gnome-terminal
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    inputs.swww.packages.${pkgs.system}.swww
    libnotify
    wl-clipboard
    inputs.zen-browser.packages."${system}".beta
    graalvm-ce
    zulu8
    zulu17
    zulu
    temurin-bin
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    sbctl
    kitty
    inputs.yazi.packages.${pkgs.system}.default
    qpwgraph
    pavucontrol
    pulsemixer
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtsvg
    bibata-cursors
    heroic
    networkmanagerapplet
    clapper
    libopus
    libvlc
    cachix
    electron
    vkbasalt-cli
    dxvk_2
    nv-codec-headers-12
    vivaldi-ffmpeg-codecs
    w3m-full
    libsecret
    gcc
    sqlite
    lua53Packages.sqlite
    sqlite-utils
    vscode-extensions.vadimcn.vscode-lldb
    lldb
    gamemode
    mangohud
    nemo-with-extensions
    wine-wayland
    xdg-user-dirs
    xdg-user-dirs-gtk
    kdePackages.qtsvg
    kdePackages.qtvirtualkeyboard
    kdePackages.qtmultimedia
    kdePackages.qtdeclarative
    kdePackages.qtshadertools
    (sddm-astronaut.override {
      themeConfig = {
        ScreenWidth = "1920";
        ScreenHeight = "1080";

        Font = "Noto Sans Nerd Font";
        FontSize = "12";

        RoundCorners = "20";

        BackgroundPlaceholder = "${../../home/backgrounds/Neon-Beast-Girl.png}";
        Background = "${../../home/backgrounds/Neon-Beast-Girl.mp4}";
        BackgroundSpeed = "1.0";
        PauseBackground = "";
        CropBackground = "false";
        BackgroundHorizontalAlignment = "center";
        BackgroundVerticalAlignment = "center";
        DimBackground = "0.0";
        HeaderTextColor = "#cdd6f4";
        DateTextColor = "#cdd6f4";
        TimeTextColor = "#cdd6f4";

        FormBackgroundColor = "#1e1e2e";
        BackgroundColor = "#1e1e2e";
        DimBackgroundColor = "#1e1e2e";

        LoginFieldBackgroundColor = "##1e1e2e";
        PasswordFieldBackgroundColor = "#1e1e2e";
        LoginFieldTextColo = "#cba6f7";
        PasswordFieldTestColor = "#cba6f7";
        UserIconColor = "#cba6f7";
        PasswordIconColor = "#cba6f7";

        PlaceholderTextColor = "#a6adc8";
        WarningColor = "#f38ba8";

        LoginButtonTextColor = "#cba6f7";
        LoginButtonBackgroundColor = "#1e1e2e";
        SystemButtonsIconsColor = "#cba6f7";
        SessionButtonTextColor = "#cba6f7";
        VirtualKeyboardButtonTextColor = "#cba6f7";

        DropdownTextColor = "#cba6f7";
        DropdownSelectedBackgroundColorrr = "#1e1e2e";
        DropdownBackgroundColor = "#1e1e2e";

        HighlightTextColor = "#cba6f7";
        HighlightBackgroundColor = "#cba6f7";
        HighlightBorderColor = "#cba6f7";

        HoverUserIconColor = "#91d7e3";
        HoverPasswordIconColor = "#91d7e3";
        HoverSystemButtonsIconColor = "#91d7e3";
        HoverSessionButtonTextColor = "#91d7e3";
        HoverVirtualKeyboardButtonTextColor = "#91d7e3";

        PartialBlue = "true";
        BlurMax = "35";
        Blur = "2.0";

        HaveFormBackground = "false";
        FormPosition = "left";
      };
    })
  ];
  environment.shells = with pkgs; [zsh];

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  virtualisation.waydroid.enable = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      enable = true;
      args = [
        "--backend drm"
        "-h 1080"
        "-w 1920"
        # "-e"
        "--force-grab-cursor"
        "-r 144"
      ];
      #   env = {
      #     ENABLE_GAMESCOPE_WSI = "0";
      #   };
    };
    extraPackages = with pkgs; [
      gamescope
      libkrb5
      keyutils
    ];
    protontricks.enable = true;
  };
}
