{ pkgs, ... }: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        package = pkgs.neovim-unwrapped;
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
        filetree.nvimTree = {
          enable = true;
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
          animate.enable = true;
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        autopairs.nvim-autopairs.enable = true;
        dashboard.startify.sessionPersistence = true;
        tabline.nvimBufferline.enable = true;
        ui.noice.enable = true;       
        diagnostics.nvim-lint.enable = true;
      };
    };
  };
}
