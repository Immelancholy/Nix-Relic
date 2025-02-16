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
        enableLuaLoader = true;
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
        assistant.copilot = {
          enable = true;
          cmp.enable = true;
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
        debugger.nvim-dap.enable = true;
        binds.whichKey.enable = true;
        mini = {
          tabline.enable = true;
          basics.enable = true;
          bracketed.enable = true;
        };
      };
    };
  };
}
