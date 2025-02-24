{
  imports = [
    ./catppuccin.nix
  ];
  programs.waybar.style = ''
     * {
        border: none;
        border-radius: 0px;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 10px;
        min-height: 10px;
    }

    window#waybar {
        background: transparent;
    }

    tooltip {
        background: alpha(@base, 0.8);
        color: @text;
        border-radius: 7px;
        border-width: 0px;
    }


    #workspaces button {
        box-shadow: none;
        text-shadow: none;
        padding: 0px;
        border-radius: 9px;
        margin-top: 3px;
        margin-bottom: 3px;
        margin-left: 0px;
        padding-left: 3px;
        padding-right: 3px;
        margin-right: 0px;
        color: @text;
        animation: ws_normal 20s ease-in-out 1;
    }

    #workspaces button.active {
        background: alpha(@mauve, 0.92);
        color: @surface0;
        margin-left: 3px;
        padding-left: 12px;
        padding-right: 12px;
        margin-right: 3px;
        animation: ws_active 20s ease-in-out 1;
        transition: all 0.4s cubic-bezier(.55, -0.68, .48, 1.682);
    }

    #workspaces button:hover {
        background: alpha(@sky, 0.92);
        color: @surface0;
        animation: ws_hover 20s ease-in-out 1;
        transition: all 0.3s cubic-bezier(.55, -0.68, .48, 1.682);
    }

    #tray menu * {
        min-height: 16px
    }

    #tray menu separator {
        min-height: 10px
    }

    #backlight,
    #battery,
    #bluetooth,
    #clock,
    #clock,
    #cpu,
    #idle_inhibitor,
    #language,
    #memory,
    #mpris,
    #network,
    #custom-power,
    #privacy,
    #pulseaudio,
    #tray,
    #window,
    #workspaces,
    #workspaces,
    #workspaces,
    #custom-l_end,
    #custom-r_end,
    #custom-sl_end,
    #custom-sr_end,
    #custom-rl_end,
    #custom-rr_end {
        color: @text;
        background: alpha(@base, 0.8);
        opacity: 1;
        margin: 4px 0px 4px 0px;
        padding-left: 4px;
        padding-right: 4px;
        border-bottom: 2px solid alpha(@mauve, 0.92);
    }

    #workspaces,
    #taskbar {
        padding: 0px;
    }

    #custom-r_end {
        border-radius: 0px 21px 21px 0px;
        margin-right: 9px;
        padding-right: 3px;
    }

    #custom-l_end {
        border-radius: 21px 0px 0px 21px;
        margin-left: 9px;
        padding-left: 3px;
    }

    #custom-sr_end {
        border-radius: 0px;
        margin-right: 9px;
        padding-right: 3px;
    }

    #custom-sl_end {
        border-radius: 0px;
        margin-left: 9px;
        padding-left: 3px;
    }

    #custom-rr_end {
        border-radius: 0px 7px 7px 0px;
        margin-right: 9px;
        padding-right: 3px;
    }

    #custom-rl_end {
        border-radius: 7px 0px 0px 7px;
        margin-left: 9px;
        padding-left: 3px;
    }

    #custom-cava {
        color: @text;
        background: alpha(@base, 0.8);
        opacity: 1;
        margin: 4px 0px 4px 0px;
        padding-left: 4px;
        padding-right: 4px;
        border-bottom: 2px solid alpha(@mauve, 0.92);
    }
  '';
}
