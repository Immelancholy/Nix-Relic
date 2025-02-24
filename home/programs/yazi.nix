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
      yamb = "${inputs.yamb}";
    };
    flavors = {
      catppuccin-mocha = "${inputs.yazi-flavors}/catppuccin-mocha.yazi";
    };
    initLua = ''
      local bookmarks = {}

      local path_sep = package.config:sub(1, 1)
      local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
      if ya.target_family() == "windows" then
        table.insert(bookmarks, {
          tag = "Scoop Local",

          path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
          key = "p"
        })
        table.insert(bookmarks, {
          tag = "Scoop Global",
          path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
          key = "P"
        })
      end
      require("full-border"):setup {
        -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
        type = ui.Border.ROUNDED,
      }
      require("git"):setup()
      require("yamb"):setup {
        bookmarks = bookmarks,

        jump_notify = true,

        cli = "fzf",

        keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

        path = (os.getenv("HOME") .. "/.config/yazi/bookmark"),
      }
    '';
    settings = {
      manager = {
        show_hidden = true;
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
    keymap = {
      manager.prepend_keymap = [
        {
          on = "M";
          run = "plugin mount";
        }
        {
          on = ["u" "a"];
          run = "plugin yamb save";
          desc = "Add bookmark";
        }
        {
          on = ["u" "g"];
          run = "plugin yamb jump_by_key";
          desc = "Jump bookmark by key";
        }
        {
          on = ["u" "G"];
          run = "plugin yamb jump_by_fzf";
          desc = "Jump bookmark by fzf";
        }
        {
          on = ["u" "d"];
          run = "plugin yamb delete_by_key";
          desc = "Delete bookmarks by key";
        }
        {
          on = ["u" "D"];
          run = "plugin yamb delete_by_fzf";
          desc = "Delete bookmark by fzf";
        }
        {
          on = ["u" "A"];
          run = "plugin yamb delete_all";
          desc = "Delete all bookmarks";
        }
        {
          on = ["u" "r"];
          run = "plugin yamb rename_by_key";
          desc = "Rename bookmark by key";
        }
        {
          on = ["u" "R"];
          run = "plugin yamb rename_by_fzf";
          desc = "Rename bookmark by fzf";
        }
      ];
    };
  };
}
