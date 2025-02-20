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
    mangohud
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
    gamescopeSession.enable = true;
    extraPackages = with pkgs; [
      gamescope
      gamemode
    ];
  };
}
