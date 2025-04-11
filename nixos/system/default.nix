{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./fonts
    ./programs
    ./extracache.nix
    ./env.nix
  ];
  programs.seahorse.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.seatd.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment = {
    shells = with pkgs; [
      zsh
    ];
  };

  security.sudo = {
    execWheelOnly = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    swapDevices = 1;
    priority = 100;
  };

  security.apparmor = {
    enable = false;
    packages = with pkgs; [
      roddhjav-apparmor-rules
      apparmor-profiles
      apparmor-parser
    ];
  };

  networking.hostName = "nixos";

  networking.firewall = {
    enable = true;
  };
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  users.defaultUserShell = pkgs.zsh;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    sddm = {
      enable = false;
      flavor = "mocha";
      font = "Noto Sans Nerd Font";
      fontSize = "12";
      background = ../home/backgrounds/anime-girl-wings.jpg;
      loginBackground = true;
    };
  };

  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 2d";
  };
  nix.settings.auto-optimise-store = true;
  # ...
  system.stateVersion = "25.05";
}
