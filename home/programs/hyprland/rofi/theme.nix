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
        font = "JetBrainsMono";

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
    }
  );
}
