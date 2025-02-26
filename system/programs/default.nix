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
      themeConfig = {
        ScreenWidth = "1920";
        ScreenHeight = "1080";

        Font = "Noto Sans Nerd Font";
        FontSize = "12";

        RoundCorners = "20";

        background = "${../../home/backgrounds/anime-girl-wings.jpg}";
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
