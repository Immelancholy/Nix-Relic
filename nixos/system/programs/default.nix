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
    ./scripts
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

  programs.zsh.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      libsecret
      gcr_4
    ];
  };
  environment.systemPackages = with pkgs; [
    mpc
    ffmpegthumbnailer
    libcamera
    mpvpaper
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
    graalvm-ce
    inputs.zen-browser.packages.${pkgs.system}.default
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
    gcr_4
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
  programs.ssh = {
    startAgent = false;
    enableAskPassword = true;
    askPassword = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  };
  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";

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
