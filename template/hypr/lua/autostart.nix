{
  xdg.configFile."hypr/lua/autostart.lua".text = /* Lua */ ''
    hl.on("hyprland.start", function()
      hl.timer(function()
        hl.exec_cmd(Discord)
        hl.exec_cmd(Browser, { workspace = "2 silent" })
      end, { timeout = 1, type = "oneshot" })
    end)
    hl.on("config.reloaded", function()
      hl.timer(function()
        hl.exec_cmd("systemctl restart --user easyeffects")
        hl.exec_cmd("systemctl restart --user qpwgraph")
        hl.exec_cmd("systemctl restart --user waybar")
      end, { timeout = 1, type = "oneshot" })
    end)
  '';
}
