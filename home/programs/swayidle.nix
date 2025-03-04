{
  pkgs,
  inputs,
  ...
}: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 10;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 15;
        command = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
