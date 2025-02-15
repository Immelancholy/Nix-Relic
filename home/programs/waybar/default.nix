{
  programs.waybar = { 
    enable = true;
    systemd.enable = true;
  };

  imports = [
    ./waybarsettings.nix
    ./waybarcss.nix
  ];
}
