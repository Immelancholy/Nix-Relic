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
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#cdd6f4";

        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };
      "window" = {
        location = mkLiteral "north";
        y-offset = mkLiteral "calc(50% - 176px)";
        width = mkLiteral "480";
        border-radius = mkLiteral "24px";

        background-color = mkLiteral "#1e1e2e";
      };
      "mainbox" = {
        padding = mkLiteral "12px";
      };
      "inputbar" = {
        background-color = mkLiteral "#1e1e2e";
        border-color = mkLiteral "#cba6f7";

        border = mkLiteral "2px";
        border-radius = mkLiteral "16px";

        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        childern = mkLiteral "[ prompt, entry ]";
      };
      "promp" = {
        text-color = mkLiteral "#cdd6f4";
      };
      "entry" = {
        placeholder = "Search";
        placeholder-color = mkLiteral "#cdd6f4";
      };
      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = mkLiteral "16px";
        border-color = mkLiteral "#cba6f7";
        background-color = mkLiteral "#cba6f7";
      };
    }
  );
}
