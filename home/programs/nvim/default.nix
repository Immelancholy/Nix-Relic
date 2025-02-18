{ pkgs, inputs, ... }: {
	programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
		colorschemes.catppuccin.enable = true;
		colorscheme = "catppuccin-mocha";
		vimAlias = true;
		withNodeJs = true;
    withPerl = true;
    luaLoader.enable = true;
		plugins = {
      rustaceanvim.enable = true;
      lz-n.enable = true;
			lualine.enable = true;
			snacks = {
      enable = true;
        settings = {
          bigfile = {
            enabled = true;
          };
          notifier = {
            enabled = true;
            timeout = 3000;
          };
          quickfile = {
            enabled = false;
          };
          statuscolumn = {
            enabled = false;
          };
        };
			};
			blink-cmp = {
        enable = true;
      };
      nvim-autopairs.enable = true;
      yanky.enable = true;
      blink-cmp-dictionary.enable = true;
      blink-cmp-git.enable = true;
      blink-ripgrep.enable = true;
      treesitter.enable = true;
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
			nix.enable = true;
			nix-develop.enable = true;
      web-devicons.enable = true;
      smear-cursor.enable = true;
      which-key.enable = true;
      telescope.enable = true;
      dashboard.enable = true;
      toggleterm.enable = true;
      treesj.enable = true;
      luasnip.enable = true;
      lazygit.enable = true;
      dap.enable = true;
      dap-go.enable = true;
      dap-python.enable = true;
      dap-ui.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          hyprls.enable = true;
          # rust_analyzer = {
          #   enable = true;
          #   installCargo = true;
          #   installRustc = true;
          # };
          lua_ls.enable = true;
          pylyzer.enable = true;
        };
      };
      lsp-format.enable = true;
      lsp-signature.enable = true;
      lsp-lines.enable = true;
      lsp-status.enable = true;
      harpoon = {
        enable = true;
      };
      indent-blankline = {
        enable = true;
        settings = {
          exclude = {
            buftypes = [
              "terminal"
              "quickfix"
            ];
            filetypes = [
              ""
              "checkhealth"
              "help"
              "lspinfo"
              "TelescopePrompt"
              "TelescopeResults"
              "dashboard"
            ];
          };
        };
      };
      neo-tree = {
        enable = true;
        enableGitStatus = true;
      };
		};
		opts = {
			tabstop = 2;
			shiftwidth = 0;
		};
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
      nvim-window-picker
    ];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    keymaps = [
      {
        action = "<Cmd>Neotree toggle<CR>";
        key = "<leader>e";
        mode = ["n" "v"];
      }
    ];
	};
}
