{
  config,
  lib,
  ...
}: {
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
        bg0 = mkLiteral "#1e1e2ecc";
        bg1 = mkLiteral "#1e1e2ecc";
        bg2 = mkLiteral "#b4befecc";
        bg3 = mkLiteral "#cba6f7cc";
        fg0 = mkLiteral "#cdd6f4";
        fg1 = mkLiteral "#11111b";
        fg2 = mkLiteral "#bac2de";
        fg3 = mkLiteral "#9399b2";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };
      "window" = {
        location = mkLiteral "north";
        y-offset = mkLiteral "calc(45% - 176px)";
        width = mkLiteral "480";
        border-radius = mkLiteral "24px";

        background-color = mkLiteral "@bg0";
      };
      "mainbox" = {
        padding = mkLiteral "12px";
      };
      "inputbar" = {
        background-color = mkLiteral "@bg1";
        border-color = mkLiteral "@bg3";

        border = mkLiteral "2px";
        border-radius = mkLiteral "16px";

        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        childern = mkLiteral "[ prompt, entry ]";
      };
      "promp" = {
        text-color = mkLiteral "@fg2";
      };
      "entry" = {
        placeholder = "Search";
        placeholder-color = mkLiteral "@fg3";
      };
      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = mkLiteral "16px";
        border-color = mkLiteral "@bg2";
        background-color = mkLiteral "@bg2";
      };
      "textbox" = {
        padding = mkLiteral "8px 24px";
      };
      "listview" = {
        background-color = mkLiteral "transparent";

        margin = mkLiteral "12px 0 0";
        lines = mkLiteral "8";
        columns = mkLiteral "1";

        fixed-heigh = mkLiteral "false";
      };
      "element" = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "16px";
      };
      "element normal active" = {
        text-color = mkLiteral "@bg3";
      };
      "element selected normal, element selected active" = {
        background-color = mkLiteral "@bg3";
      };
      "element-icon" = {
        size = mkLiteral "2em";
        vertical-align = mkLiteral "0.5";
      };
      "element-text" = {
        text-color = mkLiteral "inherit";
      };
    }
  );
}
