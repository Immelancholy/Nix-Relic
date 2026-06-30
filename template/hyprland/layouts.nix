{
  xdg.configFile."hypr/layouts.lua".text = /* Lua */ ''
    hl.config({
      general = {
        layout = "scrolling",
      },
      dwindle = {
        preserve_split = true,
      },
      master = {
        drop_at_cursor = true,
      },
    })
  '';
}
