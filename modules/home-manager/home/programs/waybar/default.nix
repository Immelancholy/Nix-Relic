{
  programs.waybar = {
    enable = true;
  };

  imports = [
    ./waybarsettings.nix
    ./waybarcss.nix
  ];
}
