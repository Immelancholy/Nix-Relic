{
  pkgs,
  outputs,
  inputs,
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

  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
      inputs.nix-relic-modules.overlays.nix-relic-modules
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = ["nix-command" "flakes"];

      flake-registry = "";

      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

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

  environment.pathsToLink = ["/share/zsh"];

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

  users.defaultUserShell = pkgs.zsh;

  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
  # ...
  system.stateVersion = "25.05";
}
