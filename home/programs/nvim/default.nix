{ pkgs, inputs, ... }: {
	programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          cmp = true;
          gitsigns = true;
          mini = {
            enabled = true;
          };
          treesitter = true;
        };
        styles = {
          booleans = [
            "bold"
            "italic"
          ];
          conitionals = [
            "bold"
          ];
        };
        term_colors = true;
      };
    };
		colorscheme = "catppuccin";
		vimAlias = true;
		withNodeJs = true;
    withPerl = true;
    luaLoader.enable = true;
		plugins = {
      barbar.enable = true;
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
      nvim-autopairs.enable = true;
      yanky.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              })
            '';
          };
          sources = [
            {
              name = "nvim_lsp";
            }
            {
              name = "luasnip";
            }
            {
              name = "path";
            }
            {
              name = "buffer";
            }
          ];
        };
      };
      cmp-async-path.enable = true;
      cmp-cmdline.enable = true;
      cmp-buffer.enable = true;
      cmp-dap.enable = true;
      cmp-dictionary.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-spell.enable = true;
      cmp_luasnip.enable = true;
      cmp_yanky.enable = true;
      cmp-treesitter.enable = true;
      cmp-nvim-lua.enable = true;
      bufdelete.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          nix
        ];
        settings = {
          auto_install = true;
        };
      };
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
        autoLoad = true;
        servers = {
          nixd.enable = true;
          hyprls.enable = true;
          lua_ls.enable = true;
          pylyzer.enable = true;
        };
      };
      lsp-format.enable = true;
      lsp-signature.enable = true;
      lsp-lines.enable = true;
      lsp-status = {
        autoLoad = true;
        enable = true;
      };
      lspkind = {
        enable = true;
        cmp.enable = true;
      };
      harpoon = {
        enable = true;
      };
      mini = {
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
      number = true;
      relativenumber = true;
		};
		extraPlugins = with pkgs.vimPlugins; [
			plenary-nvim
      nvim-window-picker
      neogit
      cmp-zsh
      vimacs
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
