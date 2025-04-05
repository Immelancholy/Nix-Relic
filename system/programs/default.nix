{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./pipewire.nix
    ./flatpak.nix
    ./weylus.nix
    ./bluetooth.nix
    ./DM
    ./uwsm.nix
    ./steam.nix
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };

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
  ];
  environment.shells = with pkgs; [zsh];

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  virtualisation.waydroid.enable = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
