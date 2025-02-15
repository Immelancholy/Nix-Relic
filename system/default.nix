{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./fonts
    ./programs
    ../modules
    ./extracache.nix
  ];
  
  services.solaar.enable = true;

  networking.hostName = "nixos";
  networking.firewall.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  users.defaultUserShell = pkgs.zsh;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    sddm.enable = false;
  };

  system.autoUpgrage = {
    enable = true;
    dates = "weekly";
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
    auto-optimise-store = true;
  };

  system.stateVersion = "24.05";
}
