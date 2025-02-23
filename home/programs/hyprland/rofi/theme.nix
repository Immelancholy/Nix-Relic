{config, ...}: {
  programs.rofi.theme = (
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
        bg0 = mkLiteral "#1e1e2e";
        bg1 = mkLiteral "#1e1e2e";
        bg2 = mkLiteral "#b4befe";
        bg3 = mkLiteral "#cba6f7";
        fg0 = mkLiteral "#cdd6f4";
        fg1 = mkLiteral "#a6adc8";
        fg2 = mkLiteral "#bac2de";
        fg3 = mkLiteral "#a6adc8";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };
      "window" = {
        location = mkLiteral "north";
        y-offset = mkLiteral "calc(50% - 176px)";
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
    }
  );
}
