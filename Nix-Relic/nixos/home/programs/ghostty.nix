{
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
    installVimSyntax = true;
    settings = {
      font-synthetic-style = false;
      cursor-style-blink = true;
      cursor-click-to-move = true;
      window-padding-balance = true;
      window-padding-x = 5;
      window-padding-y = 5;
      background-opacity = 0.8;
      window-padding-color = "background";
      title = "ghostty";
      alpha-blending = "linear-corrected";
      bold-is-bright = true;
    };
  };
}
