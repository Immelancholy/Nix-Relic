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
    ./swayidle.nix
    ./obs.nix
    ./rofi
    ./scripts
    ./dunst.nix
    ./swaylock.nix
    ./udiskie.nix
    ./cliphist.nix
  ];

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  services.mpris-proxy = {
    enable = true;
  };

  home.packages = with pkgs; [
    vesktop
    grim
    slurp
    inputs.zen-browser.packages."${system}".beta
    pipes
    lazygit
    loupe
    glycin-loaders
    swappy
    eza
    libsixel

    shotcut

    krita

    manix

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
    kdePackages.ark
    parted
    qalculate-gtk
    libreoffice
    fd
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
