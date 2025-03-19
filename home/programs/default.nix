{
  pkgs,
  inputs,
  git,
  email,
  ...
}: {
  imports = [
    ./hyprland
    ./waybar
    ./yazi.nix
    ./mpd
    ./cava
    ./fastfetch
    ./nvim
    ./easyeffects
    ./rmpc
    ./tmux.nix
    ./kitty.nix
    ./spicetify.nix
    ./DAW
    ./swayidle.nix
    ./eww
    ./obs.nix
  ];

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  services.remmina = {
    enable = true;
    addRdpMimeTypeAssoc = true;
  };
  home.packages = with pkgs; [
    hyprpicker
    hyprshot
    inputs.zen-browser.packages."${system}".beta
    pipes
    lazygit
    loupe
    glycin-loaders
    swappy
    eza
    libsixel

    shotcut

    hyprcursor

    krita

    manix

    linux-wallpaperengine

    # archives
    zip
    xz
    unzip
    p7zip
    ventoy
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
    neo

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
    rmpc
    mpd
    protonup
    playerctl
    pokemonsay
    fortune
    cowsay
    lz4
    qpwgraph
    kdePackages.ark
    parted
    teams-for-linux
    retroarch-free
    qalculate-gtk
    libreoffice
    fd
    (discord.override {
      withOpenASAR = true; # can do this here too
      withVencord = true;
    })
    (pkgs.ffmpeg-full.override {
      withUnfree = true;
      withOpengl = true;
      withRtmp = true;
      withNvenc = true;
    })
    obsidian
    obsidian-export
    wordnet
    rustlings
  ];

  xdg.desktopEntries = {
    discord = {
      name = "Discord";
      genericName = "All-in-one cross-platform voice and text chat for gamers";
      type = "Application";
      exec = "Discord --enable-features=UseOzonePlatform --ozone-platform=x11";
      icon = "discord";
      mimeType = ["x-scheme-handler/discord"];
      categories = ["Network" "InstantMessaging"];
    };
  };

  programs.zoxide = {
    enable = true;
  };
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "${git}";
    userEmail = "${email}";
  };
}
