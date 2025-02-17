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
    background: @crust;
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
    background: @subtext0;
    color: @surface0;
    margin-left: 3px;
    padding-left: 12px;
    padding-right: 12px;
    margin-right: 3px;
    animation: ws_active 20s ease-in-out 1;
    transition: all 0.4s cubic-bezier(.55, -0.68, .48, 1.682);
}

#workspaces button:hover {
    background: @mauve;
    color: @surface0;
    animation: ws_hover 20s ease-in-out 1;
    transition: all 0.3s cubic-bezier(.55, -0.68, .48, 1.682);
}

#taskbar button {
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
    animation: tb_normal 20s ease-in-out 1;
}

#taskbar button.active {
    background: @subtext0;
    color: @surface0;
    margin-left: 3px;
    padding-left: 12px;
    padding-right: 12px;
    margin-right: 3px;
    animation: tb_active 20s ease-in-out 1;
    transition: all 0.4s cubic-bezier(.55, -0.68, .48, 1.682);
}

#taskbar button:hover {
    background: @mauve;
    color: @surface0;
    animation: tb_hover 20s ease-in-out 1;
    transition: all 0.3s cubic-bezier(.55, -0.68, .48, 1.682);
}

#tray menu * {
    min-height: 16px
}

#tray menu separator {
    min-height: 10px
}

  '';
}
