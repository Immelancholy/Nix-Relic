{pkgs, ...}: let
  hyprgame = pkgs.writeShellScriptBin "hg" ''
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
