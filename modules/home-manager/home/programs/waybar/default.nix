{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    # package = pkgs.stable.waybar;
    systemd.enable = true;
  };

  imports = [
    ./waybarsettings.nix
    ./waybarcss.nix
  ];
}
