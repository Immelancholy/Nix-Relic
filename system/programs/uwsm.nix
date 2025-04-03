{pkgs, ...}: let
  hg = pkgs.writeShellScriptBin "hg" ''
    config=/home/mela/hyprcord.config
    exec Hyprland --config $config
  '';
in {
  environment.systemPackages = [
    hg
  ];
  programs = {
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprgame = {
          prettyName = "Hyprland (GameMode)";
          comment = "Barebones config to go with steamdeck mode";
          binPath = "/run/current-system/sw/bin/hg";
        };
      };
    };
  };
}
