{ config, lib, ... }:
let
  inherit (config.lib.stylix) colors;
  inherit (config.stylix) fonts;
  mkHex = colors: builtins.mapAttrs (_: value: "#${value}") colors;
  colors-hex = mkHex colors;
  font =
    if lib.hasSuffix " Mono" fonts.monospace.name then
      lib.removeSuffix " Mono" fonts.monospace.name
    else
      fonts.monospace.name;
in
with colors-hex;
{
  programs.waybar.style = /* CSS */ ''
     * {
        border: none;
        border-radius: 0px;
        font-family: "${font}";
        font-weight: bold;
        font-size: ${toString fonts.sizes.desktop}px;
        min-height: 11px;
    }

    window#waybar {
        background: transparent;
    }

    tooltip {
        background: alpha(alpha(${base00}, 0.65), 0.8);
        color: ${base05};
        border-radius: 7px;
        border-width: 0px;
    }

    #workspaces button {
        box-shadow: none;
        text-shadow: none;
        padding: 0px;
        border-radius: 9px;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-left: 0px;
        padding-left: 4px;
        padding-right: 3px;
        margin-right: 0px;
        color: ${base05};
        animation: ws_normal 20s ease-in-out 1;
    }

    #workspaces button.active {
        background: radial-gradient(circle farthest-side, transparent, transparent, transparent, transparent, transparent, transparent, transparent, transparent, transparent, transparent, transparent, ${base0C}, ${base06}, ${base0C}, transparent);
        color: ${base05};
        margin-left: 3px;
        padding-left: 13px;
        padding-right: 12px;
        margin-right: 3px;
        animation: ws_active 20s ease-in-out 1;
        transition: all 0.4s cubic-bezier(.55, -0.68, .48, 1.682);
    }

    #workspaces button:hover {
        background: radial-gradient(circle farthest-side, transparent, transparent, transparent, transparent, transparent, transparent, transparent, ${base0C}, ${base06}, ${base0C}, transparent);
        color: ${base0C};
        animation: ws_hover 20s ease-in-out 1;
        transition: all 0.3s cubic-bezier(.55, -0.68, .48, 1.682);
    }

    #tray menu * {
        min-height: 16px
    }

    #tray menu separator {
        min-height: 10px
    }

    #battery.critical {
      color: #df0f25;
    }

    #battery.warning {
      color: #ffbe27;
    }

    #backlight,
    #battery,
    #bluetooth,
    #clock,
    #clock,
    #cpu,
    #temperature,
    #idle_inhibitor,
    #language,
    #memory,
    #mpris,
    #network,
    #custom-power,
    #privacy,
    #pulseaudio,
    #tray,
    #custom-update,
    #submap,
    #window,
    #workspaces,
    #workspaces,
    #workspaces,
    #custom-l_end,
    #custom-r_end {
        color: ${base05};
        background: linear-gradient(0deg, transparent, ${base0C}, ${base06}, ${base0C}, alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), ${base0C}, ${base06}, ${base0C}, transparent);
        opacity: 1;
        margin: 1px 0px 4px 0px;
        padding-left: 4px;
        padding-right: 4px;
    }

    #workspaces,
    #taskbar {
        padding: 0px;
    }

    #custom-r_end {
        border-radius: 0px 21px 21px 0px;
        background: radial-gradient(ellipse farthest-side, alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), ${base0C}, ${base06}, ${base0C}, transparent);
        background-size: 200% 100%;
        background-position: 100% 0%;
        margin-right: 9px;
        padding-right: 3px;
    }

    #custom-l_end {
        border-radius: 21px 0px 0px 21px;
        background: radial-gradient(ellipse farthest-side, alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), ${base0C}, ${base06}, ${base0C}, transparent);
        background-size: 200% 100%;
        margin-left: 9px;
        padding-left: 3px;
    }

    #custom-cava {
        color: ${base05};
        background: linear-gradient(0deg, transparent, ${base0C}, ${base06}, ${base0C}, alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65), alpha(${base00}, 0.65),${base0C}, ${base06}, ${base0C}, transparent);
        opacity: 1;
        margin: 1px 0px 4px 0px;
        padding-left: 4px;
        padding-right: 4px;
    }

    #custom-power {
        padding-left: 5px;
        padding-right: 8px;
    }
  '';
}
