{
  programs.git = {
    enable = true;
    userName = ""; # Git Username
    userEmail = ""; # Git Email
  };
  wayland.windowManager.hyprland = {
    # ONLY ENABLE 1 LAYOUT!!
    layout = {
      master.enable = false;
      dwindle.enable = false;
      hy3.enable = true;
    };
    useHyprspace = true;
    settings = {
      monitor = ", preferred, auto, 1";
      input = {
        kb_layout = "gb"; # Keyboard layout for hyprland
        follow_mouse = "1";

        sensitivity = "0";
        force_no_accel = "1";
        numlock_by_default = "true";
      };
    };
  };
}
