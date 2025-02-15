{
  services.hypridle.enable = true;
  programs = {
    uwsm.enable = true;
    hyprlock.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };
}
