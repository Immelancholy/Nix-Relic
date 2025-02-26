{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./pipewire.nix
    ./sddm.nix
    ./flatpak.nix
    ./obs.nix
  ];

  programs.xfconf.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.dconf.enable = true;

  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  programs.zsh.enable = true;
  services.dbus.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".beta
    # inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    (prismlauncher.override {
      additionalPrograms = [ffmpeg];
      jdks = [
        graalvm-ce
        zulu8
        zulu17
        zulu
        temurin-bin
      ];
    })
    kitty
    inputs.yazi.packages.${pkgs.system}.default
    qpwgraph
    pavucontrol
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
    gcc
    sqlite
    lua53Packages.sqlite
    sqlite-utils
    vscode-extensions.vadimcn.vscode-lldb
    lldb
    gamemode
    mangohud
    nemo-with-extensions
    lutris-unwrapped
    wine-wayland
    xdg-user-dirs
    xdg-user-dirs-gtk
    kdePackages.qtsvg
    kdePackages.qtvirtualkeyboard
    kdePackages.qtmultimedia
    kdePackages.qtdeclarative
    kdePackages.qtshadertools
    (sddm-astronaut.override {
      embeddedTheme = "hyprland_kath";
      themeConfig = {
        background = "${../../home/backgrounds/anime-girl-wings.jpg}";
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
    gamescopeSession = {
      enable = true;
      args = [
        "--backend drm"
        "-h 1080"
        "-w 1920"
        "-e"
        "--force-grab-cursor"
        "-f"
        "--mangoapp"
        "--rt"
      ];
      env = {
        ENABLE_GAMESCOPE_WSI = "0";
        STEAM_MULTIPLE_XWAYLANDS = "0";
        STEAM_GAMESCOPE_HDR_SUPPORTED = "1";
        STEAM_GAMESCOPE_VRR_SUPPORTED = "1";
        STEAM_MANGOAPP_PRESETS_SUPPORTED = "1";
        STEAM_DISABLE_MANGOAPP_ATOM_WORKAROUND = "1";
        SRT_URLOPEN_PREFER_STEAM = "1";
        __GL_MaxFramesAllowed = "1";
      };
    };
    extraPackages = with pkgs; [
      gamescope
    ];
    protontricks.enable = true;
  };
}
