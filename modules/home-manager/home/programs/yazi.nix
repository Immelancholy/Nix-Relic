{
  pkgs,
  nix-relic,
  ...
}:
{
  programs.yazi = {
    enable = true;
    package = nix-relic.inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableZshIntegration = true;
    shellWrapperName = "y";
    plugins = {
      full-border = "${nix-relic.inputs.yazi-plugins}/full-border.yazi";
      git = "${nix-relic.inputs.yazi-plugins}/git.yazi";
      mount = "${nix-relic.inputs.yazi-plugins}/mount.yazi";
      yamb = "${nix-relic.inputs.yamb}";
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
        play = [
          {
            run = "uwsm-app -- mpv --player-operation-mode=pseudo-gui %s";
            orphan = true;
            for = "unix";
          }
        ];
        image = [
          {
            run = "uwsm-app -- loupe %s";
            orphan = true;
            for = "unix";
          }
        ];
        edit = [
          {
            run = "uwsm-app -- $EDITOR %s";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "uwsm-app -- xdg-open %s";
            desc = "Open";
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = "edit";
          }
          {
            url = "*.json";
            use = "edit";
          }
          {
            url = "*.html";
            use = [
              "open"
              "edit"
            ];
          }
          {
            mime = "video/*";
            use = "play";
          }
          {
            mime = "audio/*";
            use = "play";
          }
          {
            mime = "image/*";
            use = "image";
          }
        ];
      };
      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
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
          on = [
            "u"
            "a"
          ];
          run = "plugin yamb save";
          desc = "Add bookmark";
        }
        {
          on = [
            "u"
            "g"
          ];
          run = "plugin yamb jump_by_key";
          desc = "Jump bookmark by key";
        }
        {
          on = [
            "u"
            "G"
          ];
          run = "plugin yamb jump_by_fzf";
          desc = "Jump bookmark by fzf";
        }
        {
          on = [
            "u"
            "d"
          ];
          run = "plugin yamb delete_by_key";
          desc = "Delete bookmarks by key";
        }
        {
          on = [
            "u"
            "D"
          ];
          run = "plugin yamb delete_by_fzf";
          desc = "Delete bookmark by fzf";
        }
        {
          on = [
            "u"
            "A"
          ];
          run = "plugin yamb delete_all";
          desc = "Delete all bookmarks";
        }
        {
          on = [
            "u"
            "r"
          ];
          run = "plugin yamb rename_by_key";
          desc = "Rename bookmark by key";
        }
        {
          on = [
            "u"
            "R"
          ];
          run = "plugin yamb rename_by_fzf";
          desc = "Rename bookmark by fzf";
        }
      ];
    };
  };
}
