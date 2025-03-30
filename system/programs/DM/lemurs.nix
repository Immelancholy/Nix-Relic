{pkgs, ...}: {
  services.displayManager = {
    enable = true;
    execCmd = "${pkgs.lemurs}/bin/lemurs";
  };
  environment.etc."lemurs/wms/hyprland-uwsm" = {
    text = ''
      #!/bin/sh
      zsh --login -c 'uwsm start hyprland-uwsm.desktop'
    '';
    executable = true;
  };
}
