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
        # timeout = 900;
        timeout = 30;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        # timeout = 905;
        timeout = 35;
        command = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
