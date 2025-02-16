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
        # enableLuaLoader = true;
        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
        };
        autocomplete.nvim-cmp = {
          enable = true;
        };
        statusline.lualine.enable = true;
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            git_status_async = true;
          };
        };
        fzf-lua.enable = true;
        treesitter = {
          enable = true;
          indent.enable = true;
        };
        visuals = {
          indent-blankline.enable = true;
          nvim-web-devicons.enable = true;
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
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        autopairs.nvim-autopairs.enable = true;
        dashboard.startify.sessionPersistence = true;
        tabline.nvimBufferline.enable = true;
        ui.noice.enable = true;
        notes.neorg.enable = true;
        keymaps = [
          {
            key = "<leader>e";
            mode = ["n" "v"];
            action = ":Neotree toggle<CR>";
          }
        ];
        visuals = {
          cinnamon-nvim = {
            enable = true;
          };
        };
        lazy = {
          enable = true;
          plugins = {
            smear-cursor-nvim = {
              package = pkgs.vimPlugins.smear-cursor-nvim;
              setupModules = "smear-cursor";
              setupOpts = {};
            };
          };
        };
      };
    };
  };
}
