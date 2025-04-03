{pkgs, ...}: let
  hyprgame = pkgs.writeScriptBin ''
    config="$HOME/hyprcord.config"
    exec Hyprland --config "$config"
  '';
in {
  environment.systemPackages = [
    hyprgame
  ];
  programs = {
    uwsm = {
      enable = true;
    };
  };
}
