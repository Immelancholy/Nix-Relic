{
  xdg.configFile."hypr/lua/hardware.lua".text = /* Lua */ ''
    hl.config({
      cursor = {
        no_hardware_cursors = 2,
        hide_on_key_press = true,
      },
      render = {
        direct_scanout = 1,
      },
      input = {
        kb_layout = "gb",
        kb_options = "compose:rwin",
        follow_mouse = 1,
        sensitivity = 0,
        force_no_accel = 1,
        numlock_by_default = true,
      },
      misc = {
        key_press_enables_dpms = true,
      },
    })
  '';
}
