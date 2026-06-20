{
  xdg.configFile."hypr/hardware.lua".text = /* Lua */ ''
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
    hl.monitor({
      output = "DP-1",
      mode = "1920x1080@280",
      position = "0x0",
      scale = 1,
      vrr = 1,
      bitdepth = 10,
      cm = "srgb",
      supports_wide_color = 1,
      supports_hdr = 1,
      sdr_min_luminance = 0.005,
      sdr_max_luminance = 300,
      min_luminance = 0,
      max_luminance = 300,
      max_avg_luminance = 300,
    })
    hl.monitor({
      output = "HDMI-A-1",
      mode = "2569x1440@60",
      position = "1920x0",
      scale = 1,
    })
  '';
}
