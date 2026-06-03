{
  xdg.configFile."hypr/lua/layouts.lua".text = /* Lua */ ''
    hl.config({
      general = {
        layout = "scrolling",
      },
      dwindle = {
        smart_split = true,
        precise_mouse_move = true,
      },
      master = {
        drop_at_cursor = true,
      },
    })
  '';
}
