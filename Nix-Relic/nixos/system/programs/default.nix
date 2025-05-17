{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./pipewire.nix
    ./weylus.nix
    ./bluetooth.nix
    ./uwsm.nix
    ./stylix.nix
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
  services.gnome.gnome-keyring.enable = true;

  programs.dconf.enable = true;

  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  security.wrappers.write = {
    group = "tty";
    owner = "root";
    setgid = true;
    source = "${pkgs.util-linux}/bin/write";
  };

  programs.zsh.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
  };
  systemd.user.services.hyprsunset = {
    enable = true;
    unitConfig = {
      Description = "An application to enable a blue-light filter on Hyprland.";
      Documentation = "https://wiki.hyprland.org/Hypr-Ecosystem/hyprsunset/";
      PartOf = "graphical-session.target";
      Requires = "graphical-session.target";
      After = "graphical-session.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset";
      Slice = "session.slice";
      Restart = "on-failure";
    };
    wantedBy = ["graphical-session.target"];
  };
  environment.systemPackages = with pkgs; [
    onefetch
    neo
    pipes
    brightnessctl
    mpc
    ffmpegthumbnailer
    libcamera
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
    sbctl
    inputs.yazi.packages.${pkgs.system}.default
    nrm.brightness
    nrm.btop
    nrm.cava
    (nrm.cavaCfg.override {
      color1 = "#${config.lib.stylix.colors.base0E}";
      color2 = "#${config.lib.stylix.colors.base0D}";
      color3 = "#${config.lib.stylix.colors.base0C}";
      color4 = "#${config.lib.stylix.colors.base0B}";
      color5 = "#${config.lib.stylix.colors.base0A}";
      color6 = "#${config.lib.stylix.colors.base09}";
      color7 = "#${config.lib.stylix.colors.base08}";
    })
    nrm.checkshell
    nrm.cliphist
    nrm.colortrans
    nrm.mpdchck
    (nrm.neo-color.override {
      color1 = "${config.lib.stylix.colors.base0F}";
      color2 = "${config.lib.stylix.colors.base0D}";
      color3 = "${config.lib.stylix.colors.base0E}";
      color4 = "${config.lib.stylix.colors.base0C}";
      color5 = "${config.lib.stylix.colors.base05}";
    })
    nrm.neo
    nrm.rofi-power-menu
    nrm.ss
    nrm.tmux_dev
    nrm.tmux_nix
    nrm.tmux_notes
    nrm.toggle-mute
    nrm.waycava
    qpwgraph
    pavucontrol
    pulsemixer
    bibata-cursors
    libopus
    libvlc
    cachix
    electron
    vkbasalt-cli
    dxvk_2
    nv-codec-headers-12
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
    ghostscript
    tectonic
    mermaid-cli
    python313Packages.pylatexenc
    grim
    slurp
    pipes
    lazygit
    loupe
    glycin-loaders
    swappy
    libsixel

    manix
    # archives
    zip
    xz
    unzip
    p7zip
    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    notcurses

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    protonup
    playerctl
    pokemonsay
    fortune
    cowsay
    lz4
    kdePackages.ark
    parted
    # retroarch-free
    qalculate-gtk
    libreoffice
    fd
    wordnet
  ];
  programs.ssh = {
    startAgent = true;
    # enableAskPassword = true;
    # askPassword = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  };
  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  virtualisation.waydroid.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
