{ pkgs, ... }: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.package = pkgs.neovim-unwrapped;
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
      vim.enableLuaLoader = true;
      vim.lazy.enable = true;
      vim.languages = {
         enableDAP = true;
         enableExtraDiagnostics = true;
         enableFormat = true;
         enableLSP = true;
         enableTreesitter = true;
         nix.enable = true;
      
      };
    };
  };
}
