{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./fonts
    ./programs
    ../modules
    ./extracache.nix
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    swapDevices = 1;
    priority = 100;
  };

  services.solaar.enable = true;
  services.input-remapper.enable = true;

  networking.hostName = "nixos";
  networking.firewall = {
    enable = true;
  };
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.keyMap = "uk";

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  users.users.mela = {
    isNormalUser = true;
    description = "mela";
    extraGroups = ["networkmanager" "wheel"];
  };

  users.defaultUserShell = pkgs.zsh;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    sddm.enable = false;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;
  # ...

  # This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
  # For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  system.stateVersion = "24.05";
}
