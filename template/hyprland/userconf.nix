{
  xdg.configFile."hypr/userconf.lua".text = /* Lua */ ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("hyprctl setcursor " .. Cursor)
      hl.exec_cmd("hyprlock")
    end)

    hl.on("config.reloaded", function()
      hl.exec_cmd("hyprctl setcursor " .. Cursor)
      hl.exec_cmd("hyprlock")
    end)

    function WorkspaceOneExecs()
      hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-cava relic-cava"))
      hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-btop relic-btop"))
      hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-neo relic-neo"))
      hl.dispatch(
        hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-fastfetch kitty @ launch --type overlay --env class=fastfetch")
      )
      hl.dispatch(hl.dsp.exec_cmd(Player))
    end

    function ExtraGameCalls() end
    function ExtraGameExitCalls() end

    function WorkspaceOneKills()
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(" .. PlayerTitle .. ")$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-neo)$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-fastfetch)$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-btop)$" }))
      hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-cava)$" }))
    end

    function Universal_User_Binds() end
    function Default_User_Binds() end
    function Manage_User_Binds() end
    function Resize_User_Binds() end
    function Move_User_Binds() end
    function Player_User_Binds() end
  '';
}
