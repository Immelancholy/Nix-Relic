{
  pkgs,
  inputs,
  ...
}: {
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -fF";
    };
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 605;
        command = "${inputs.nix-relic.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${inputs.nix-relic.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
