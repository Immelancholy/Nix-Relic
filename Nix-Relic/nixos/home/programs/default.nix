{
  home.shell = {
    enableZshIntegration = true;
  };
  imports = [
    ./hyprland
    ./waybar
    ./yazi.nix
    ./mpd
    ./cava
    ./fastfetch
    ./nvim
    ./easyeffects
    ./tmux.nix
    ./kitty.nix
    ./spicetify.nix
    ./swayidle.nix
    ./obs.nix
    ./rofi
    ./cliphist.nix
    ./dunst.nix
    ./swaylock.nix
    ./udiskie.nix
    ./mpv.nix
  ];

  programs.zen = {
    enable = true;
    defaultBrowser = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  services.mpris-proxy = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--no-cmd"
    ];
  };
}
