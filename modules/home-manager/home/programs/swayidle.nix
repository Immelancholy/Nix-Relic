{
  osConfig,
  config,
  ...
}:
let
  osCfg = osConfig;
  cfg = config;
  hyprlandPkg = osCfg.programs.hyprland.package;
  swaylockPkg = cfg.programs.swaylock.package;
in
{
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${swaylockPkg}/bin/swaylock -fF";
    };
    timeouts = [
      {
        timeout = 600;
        command = "${swaylockPkg}/bin/swaylock -fF";
      }
      {
        timeout = 610;
        command = ''${hyprlandPkg}/bin/hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "disable" }))'  '';
        resumeCommand = ''${hyprlandPkg}/bin/hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "enable" }))'  '';
      }
    ];
  };
}
