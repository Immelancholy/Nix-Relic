{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./pipewire.nix
    ./sddm.nix
    ./obs.nix
  ];

  programs.xfconf.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin # Requires an Archive manager like file-roller, ark, etc
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  programs.dconf.enable = true;

  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  programs.zsh.enable = true;
  services.dbus.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".beta
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
    selectdefaultapplication
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
  };
}
