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
  ];
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];
        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );

    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      # theme = "catppuccin-mocha";
      vim_keys = true;
    };
  };

  services.remmina = {
    enable = true;
    addRdpMimeTypeAssoc = true;
  };
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".beta
    lazygit
    loupe
    glycin-loaders
    swappy
    eza
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
    })
    obsidian
    obsidian-export
    wordnet
    rustlings
  ];

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
