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
      git = "${inputs.yazi-plugins}/git.yazi";
      mount = "${inputs.yazi-plugins}/mount.yazi";
    };
    flavors = {
      catppuccin-mocha = "${inputs.yazi-flavors}/catppuccin-mocha.yazi";
    };
    initLua = ''
      require("full-border"):setup {
        -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
        type = ui.Border.ROUNDED,
      }
      require("git"):setup()
    '';
    settings = {
      manager = {
        show_hidden = true;
        prepend_keymap = [
          {
            on = "M";
            run = "plugin mount";
          }
        ];
      };
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
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}
