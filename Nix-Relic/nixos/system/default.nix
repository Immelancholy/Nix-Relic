{
  pkgs,
  nixpkgs,
  lib,
  config,
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

  services.neo-color = {
    enable = true;
    colors = {
      color1 = "${config.lib.stylix.colors.base0F}";
      color2 = "${config.lib.stylix.colors.base0D}";
      color3 = "${config.lib.stylix.colors.base0E}";
      color4 = "${config.lib.stylix.colors.base0C}";
      color5 = "${config.lib.stylix.colors.base05}";
    };
  };

  services.cavaCfg = {
    enable = true;
    colors = {
      color1 = "#${config.lib.stylix.colors.base0E}";
      color2 = "#${config.lib.stylix.colors.base0D}";
      color3 = "#${config.lib.stylix.colors.base0C}";
      color4 = "#${config.lib.stylix.colors.base0B}";
      color5 = "#${config.lib.stylix.colors.base0A}";
      color6 = "#${config.lib.stylix.colors.base09}";
      color7 = "#${config.lib.stylix.colors.base08}";
    };
  };

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
