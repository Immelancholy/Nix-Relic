{ pkgs, inputs, ... }: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };
        enableLuaLoader = true;
        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
          python.enable = true;
          lua = {
            enable = true;
            lsp.lazydev.enable = true;
          };
        };
        autocomplete.nvim-cmp = {
          enable = true;
        };
        statusline.lualine.enable = true;
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            git.enable = true;
            git_status_async = true;
            renderer.icons.show.git = true;
            window = {  
              position = "right";
            };
          };
        };
        telescope.enable = true;
        fzf-lua.enable = true;
        treesitter = {
          enable = true;
          indent.enable = true;
        };
        visuals = {
          nvim-web-devicons.enable = true;
          indent-blankline = {
            enable = true;
            setupOpts = {
              filetype_exclude = ["dashboard"];
            };
          };
          cinnamon-nvim.enable = true;
        };
        debugger.nvim-dap = {
          enable = true;
          ui = {
            enable = true;
            autoStart = true;
          };
        }; 
        binds.whichKey.enable = true;
        mini = {
          basics.enable = true;
          bracketed.enable = true;
          pairs.enable = true;          
          indentscope = {
            enable = true;
            setupOpts = {
              symbol = "│";
              options = {
                try_as_border = true;
              };
            };
          };
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          autoindent = true;
        };
        autopairs.nvim-autopairs.enable = true;
        tabline.nvimBufferline.enable = true;
        ui.noice.enable = true;
        notes.mind-nvim.enable = true;
        keymaps = [
          {
            key = "<leader>e";
            mode = ["n"];
            action = ":Neotree toggle<CR>";
          }
        ];
        dashboard.dashboard-nvim = {
          enable = true;
          setupOpts = {
            hide = [
              "statusline"
              "tabline"
              "winbar"
            ];
          };
        };
        assistant.copilot = {
          enable = true;
          cmp.enable = true;
        };
        git.enable = true;
        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
        snippets.luasnip.enable = true;
        lazy = {
          enable = true;
          plugins = {
            "smear-cursor.nvim" = {
              package = pkgs.vimPlugins.smear-cursor-nvim;
              setupModule = "smear_cursor";
              setupOpts = {};
            };
            "nvim-window-picker" = {
              package = pkgs.vimPlugins.nvim-window-picker;
              setupModule = "window-picker";
              setupOpts = {};
            };
          };
        };
      };
    };
  };
}
