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
      lint = {
        enable = true;
        lintersByFt = {
          nix = [
            "nix"
          ];
        };
      };
      noice = {
        enable = true;
        autoLoad = true;
      };
      oil.enable = true;
      bufferline.enable = true;
      barbar.enable = true;
      rustaceanvim.enable = true;
      lz-n.enable = true;
			lualine.enable = true;
      snacks = {
        autoLoad = true;
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
      precognition = {
        enable = true;
        settings = {
          disabled_fts = [
            "dashboard"
          ];
        };
      };
      cmp = {
        autoLoad = true;
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            {
              name = "nvim_lsp";
            }
            # {
            #   name = "buffer";
            # }
            # {
            #   name = "async_path";
            # }
            # {
            #   name = "treesitter";
            # }
            {
              name = "lspkind";
            }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      bufdelete.enable = true;
      treesitter = {
        autoLoad = true;
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
        ];
        settings = {
          auto_install = true;
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = true;
          };
          incremental_selection.enable = true;
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
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          fzf-native.enable = true;
          live-grep-args.enable = true;
          ui-select.enable = true;
          undo.enable = true;
          project.enable = true;
          manix.enable = true;
        };
      };
      dashboard = {
        enable = true;
        settings = {
          change_to_vcs_root = true;
          config = {
            footer = [
              "Made with ❤️"
            ];
            header = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            mru = {
              limit = 20;
            };
            project = {
              enable = false;
            };
            shortcut = [
              {
                action = {
                  __raw = "function(path) vim.cmd('Telescope find_files') end";
                };
                desc = "Files";
                group = "Label";
                icon = " ";
                icon_hl = "@variable";
                key = "f";
              }
              {
                action = {
                  __raw = "function(path) vim.cmd('cd /etc/nixos/home/programs/ | Telescope find_files') end";
                };
                desc = " Apps";
                group = "DiagnosticHint";
                key = "a";
              }
              {
                action = {
                  __raw = "function(path) vim.cmd('cd /etc/nixos/ | Telescope find_files') end";
                };
                desc = " dotfiles";
                group = "Number";
                key = "d";
              }
            ];
            week_header = {
              enable = false;
            };
          };
          theme = "hyper";
        };
      };
      toggleterm.enable = true;
      treesj.enable = true;
      luasnip.enable = true;
      lazygit = {
        enable = true;
        settings = {
          floating_window_use_plenary = 1;
        };
      };
      dap.enable = true;
      dap-go.enable = true;
      dap-python.enable = true;
      dap-ui.enable = true;
      spider.enable = true;
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
        popupBorderStyle = "rounded";
        window = { 
          mappings = {
            l = "open";
            h = "close_node";
          };
        };
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
      vimacs
    ];
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    keymaps = [
      {
        action = "<Cmd>Neotree toggle<CR>";
        key = "<leader>e";
        mode = ["n" "v"];
      }
      {
        action = "<Cmd>LazyGit<CR>";
        key = "<leader>lg";
        options.desc = "LazyGit";
        mode = ["n"];
      }
      {
        action = "<Cmd>Dashboard<CR>";
        key = "<leader>q";
        options.desc = "Return to Dashboard";
        mode = ["n"];
      }
    ];
    clipboard = {
      register = "unnamedplus";
    };
	};
}
