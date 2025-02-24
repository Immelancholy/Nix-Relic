{
  inputs,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    plugins = {
      full-border = "${inputs.yazi-plugins}/full-border.yazi";
    };
    initLua = ''
      require("full-border"):setup {
        -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
        type = ui.Border.ROUNDED,
      }
    '';
    settings = {
      manager.show_hidden = true;
      opener = {
        edit = [
          {
            run = ''$HOME/.local/share/bin/nv.sh "$@"'';
            block = true;
            desc = ''nvim'';
            for = ''unix'';
          }
        ];
      };
    };
  };
}
