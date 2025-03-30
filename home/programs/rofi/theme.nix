{
  config,
  lib,
  ...
}: {
  ## Original Author : Aditya Shakya (adi1090x)
  ## Original Github : @adi1090x
  ## Adapted by : @GeodeArc
  ## Adapted for NixOS and modified by : @Immelancholy
  programs.rofi.theme = lib.mkDefault (
    let
      # Use `mkLiteral` for string-like values that should show without
      # quotes, e.g.:
      # {
      #   foo = "abc"; =&gt; foo: "abc";
      #   bar = mkLiteral "abc"; =&gt; bar: abc;
      # };
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        rosewater = mkLiteral "#f5e0dc";
        flamingo = mkLiteral "#f2cdcd";
        pink = mkLiteral "#f5c2e7";
        mauve = mkLiteral "#cba6f7EE";
        red = mkLiteral "#f38ba8EE";
        maroon = mkLiteral "#eba0ac";
        peach = mkLiteral "#fab387";
        yellow = mkLiteral "#f9e2af";
        green = mkLiteral "#a6e3a1";
        teal = mkLiteral "#94e2d5";
        sky = mkLiteral "#89dcebEE";
        sapphire = mkLiteral "#74c7ec";
        blue = mkLiteral "#89b4fa";
        lavender = mkLiteral "#b4befe";
        text = mkLiteral "#cdd6f4";
        text-dark = mkLiteral "#1e1e2e";
        subtext1 = mkLiteral "#bac2de";
        subtext0 = mkLiteral "#a6adc8";
        overlay2 = mkLiteral "#9399b2";
        overlay1 = mkLiteral "#7f849c";
        overlay0 = mkLiteral "#6c7086";
        surface2 = mkLiteral "#585b70";
        surface1 = mkLiteral "#45475a";
        surface0 = mkLiteral "#313244";
        base = mkLiteral "#1e1e2eBB";
        mantle = mkLiteral "#181825BB";
        crust = mkLiteral "#11111bBB";
        wallpaper = mkLiteral ''url("${../../backgrounds/Neon-Beast-Girl.png}", width)'';

        lines = mkLiteral "6";
        columns = mkLiteral "1";
        cycle = mkLiteral "false";
      };
      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = mkLiteral "false";
        width = mkLiteral "780px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        enabled = mkLiteral "true";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "20px";
        border-color = mkLiteral "@lavender";
        cursor = "default";
        background-color = mkLiteral "@base";
      };
      "mainbox" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral ''[ "inputbar", "listbox" ]'';
      };
      "listbox" = {
        spacing = mkLiteral "20px";
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral ''[ "message", "listview" ]'';
      };
      "inputbar" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        padding = mkLiteral "50px 30px";
        background-color = mkLiteral "transparent";
        background-image = mkLiteral "@wallpaper";
        text-color = mkLiteral "@text";
        orientation = mkLiteral "horizontal";
        children = mkLiteral ''[ "textbox-prompt-colon", "entry", "dummy", "mode-switcher" ]'';
      };
      "textbox-prompt-colon" = {
        enabled = mkLiteral "true";
        expand = mkLiteral "false";
        str = " :";
        padding = mkLiteral "12px 15px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@crust";
        text-color = mkLiteral "inherit";
      };
      "entry" = {
        enabled = mkLiteral "true";
        expand = mkLiteral "false";
        width = mkLiteral "250px";
        padding = mkLiteral "12px 16px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@crust";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search";
        placeholder-color = mkLiteral "@subtext0";
      };
      "dummy" = {
        expand = mkLiteral "true";
        background-color = mkLiteral "transparent";
      };
      "mode-switcher" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@text";
      };
      "button" = {
        width = mkLiteral "90px";
        padding = mkLiteral "0px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@crust";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "@mauve";
        text-color = mkLiteral "@text-dark";
      };
      "listview" = {
        enabled = mkLiteral "true";
        columns = mkLiteral "@columns";
        lines = mkLiteral "@lines";
        cycle = mkLiteral "@cycle";
        dynamic = mkLiteral "true";
        scrollbar = mkLiteral "false";
        layout = mkLiteral "vertical";
        reverse = mkLiteral "false";
        fixed-height = mkLiteral "true";
        fixed-columns = mkLiteral "true";
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@text";
        cursor = "default";
      };
      "element" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "5px";
        padding = mkLiteral "10px";
        border-radius = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@text";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@red";
        text-color = mkLiteral "@text-dark";
      };
      "element normal.active" = {
        background-color = mkLiteral "@sky";
        text-color = mkLiteral "@text-dark";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@mauve";
        text-color = mkLiteral "@text-dark";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@red";
        text-color = mkLiteral "@text";
      };
      "element selected.active" = {
        background-color = mkLiteral "@mauve";
        text-color = mkLiteral "@text-dark";
      };
      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "48px";
        cursor = mkLiteral "inherit";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "message" = {
        background-color = mkLiteral "transparent";
      };
      "textbox" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@crust";
        text-color = mkLiteral "@text";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "error-message" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@base";
        text-color = mkLiteral "@text";
      };
    }
  );
}
