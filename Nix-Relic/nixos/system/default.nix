{
  pkgs,
  nixpkgs,
  lib,
  ...
}: {
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

  services.neo-color.enable = true;
  services.cavaCfg.enable = true;

  nix.registry.nixpkgs.flake = nixpkgs;
  nix.channel.enable = false;

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

  environment.pathsToLink = ["/share/zsh"];

  nixpkgs.config.allowUnfree = true;
  environment = {
    shells = with pkgs; [
      zsh
    ];
  };

  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    swapDevices = 1;
    priority = 101;
  };

  security.apparmor = {
    enable = true;
  };

  networking.firewall = {
    enable = true;
  };
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  users.defaultUserShell = pkgs.zsh;

  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };
  nix.settings.auto-optimise-store = true;
  # ...
  system.stateVersion = "25.05";
}
