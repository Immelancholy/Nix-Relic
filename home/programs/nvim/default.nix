{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.catppuccin = {
      autoLoad = true;
      enable = true;
      settings = {
        flavour = "mocha";
        default_integrations = true;
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
        transparent_background = true;
      };
    };
    colorscheme = "catppuccin";
    vimAlias = true;
    withNodeJs = true;
    withPerl = true;
    luaLoader.enable = true;
    plugins = {
      blink-cmp = {
        enable = true;
        autoLoad = true;
        setupLspCapabilities = true;
        settings = {
          keymap = {
            preset = "default";
          };
          appearance.kind_icons = {
            Class = "󱡠";
            Color = "󰏘";
            Constant = "󰏿";
            Constructor = "󰒓";
            Enum = "󰦨";
            EnumMember = "󰦨";
            Event = "󱐋";
            Field = "󰜢";
            File = "󰈔";
            Folder = "󰉋";
            Function = "󰊕";
            Interface = "󱡠";
            Keyword = "󰻾";
            Method = "󰊕";
            Module = "󰅩";
            Operator = "󰪚";
            Property = "󰖷";
            Reference = "󰬲";
            Snippet = "󱄽";
            Struct = "󱡠";
            Text = "󰉿";
            TypeParameter = "󰬛";
            Unit = "󰪚";
            Value = "󰦨";
            Variable = "󰆦";
          };
          completion = {
            sources = {
              default = [
                "lsp"
                "buffer"
                "luasnip"
                "path"
              ];
              providers = {
                lsp = {
                  modules = "blink.cmp.sources.lsp";
                  fallbacks = [];
                };
              };
            };
          };
        };
      };
      vim-suda = {
        enable = true;
        settings = {
          smart_edit = 1;
        };
      };
      vim-surround = {
        enable = true;
      };
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
      lz-n = {
        enable = true;
        plugins = [
          {
            __unkeyed-1 = "trouble.nvim";
            after = ''
              function()
                require("trouble").setup()
              end
            '';
            cmd = ["Trouble"];
            keys = [
              {
                __unkeyed-1 = "<leader>xx";
                __unkeyed-2 = "<Cmd>Trouble diagnostics toggle<CR>";
                desc = "Diagnostics (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>xX";
                __unkeyed-2 = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
                desc = "Buffer Diagnostics (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>cs";
                __unkeyed-2 = "<cmd>Trouble symbols toggle focus=false<cr>";
                desc = "Symbols (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>cl";
                __unkeyed-2 = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
                desc = "LSP Definitions / references / ... (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>xL";
                __unkeyed-2 = "<cmd>Trouble loclist toggle<cr>";
                desc = "Location List (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>xQ";
                __unkeyed-2 = "<cmd>Trouble qflist toggle<cr>";
                desc = "Quickfix List (Trouble)";
              }
            ];
          }
        ];
      };
      snacks = {
        enable = true;
        settings = {
          bigfile = {
            enabled = true;
          };
          notifier = {
            enabled = true;
            style = "fancy";
            timeout = 3000;
          };
          quickfile = {
            enabled = true;
          };
          statuscolumn = {
            enabled = true;
          };
          words = {
            debounce = 100;
            enabled = true;
          };
        };
      };
      colorizer = {
        enable = true;
        autoLoad = true;
        settings = {
          user = {
            default_options = {
              AARRGGBB = true;
              RGB = true;
              RRGGBB = true;
              RRGGBBAA = true;
              always_update = true;
              css = true;
              css_fn = true;
              hsl_fn = true;
              mode = "background";
              names = false;
              rgb_fn = true;
              tailwind = "both";
              virtualtext = "■";
              virtualtext_inli = true;
              virtualtext_mode = "foreground";
              sass = {
                enable = true;
                parsers = [
                  "css"
                ];
              };
            };
          };
        };
      };
      lualine.enable = true;
      which-key.enable = true;
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
      # cmp = {
      #   autoLoad = true;
      #   enable = true;
      #   autoEnableSources = true;
      #   settings = {
      #     mapping = {
      #       "<C-Space>" = "cmp.mapping.complete()";
      #       "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      #       "<C-e>" = "cmp.mapping.close()";
      #       "<C-f>" = "cmp.mapping.scroll_docs(4)";
      #       "<CR>" = "cmp.mapping.confirm({ select = true })";
      #       "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      #       "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      #     };
      #     sources = [
      #       {
      #         name = "nvim_lsp";
      #       }
      #       {
      #         name = "buffer";
      #       }
      #       {
      #         name = "async_path";
      #       }
      #       {
      #         name = "treesitter";
      #       }
      #       {
      #         name = "lspkind";
      #       }
      #     ];
      #   };
      # };
      # cmp-nvim-lsp.enable = true;
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
          markdown_inline
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];
        settings = {
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
                  __raw = "function(path) vim.cmd('cd / | Telescope find_files') end";
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
              {
                action = {
                  __raw = "function(path) vim.cmd('cd ~/Documents/Notes | Telescope find_files') end";
                };
                desc = "󱓧 Notes";
                group = "Statement";
                key = "n";
              }
              {
                action = {
                  __raw = "function(path) vim.cmd('qa') end";
                };
                desc = "󰈆 Exit Neovim";
                group = "Error";
                key = "q";
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
          position = "right";
        };
        filesystem = {
          bindToCwd = true;
          cwdTarget = {
            sidebar = "tab";
            current = "window";
          };
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [
              "alejandra"
            ];
          };
          format_on_save =
            # Lua
            ''
              function(bufnr)
                local ignore_filetypes = { "sql", "jave" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                  return
                end

                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match("/node_modules/") then
                  return
                end
                -- ...additional logic...
                return { timeout_ms = 500, lsp_format = "fallback" }
              end
            '';
          format_after_save =
            # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end
                 -- ...additional logic...
                return { lsp_format = "fallback" }
              end
            '';
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            alejandra = {
              command = lib.getExe pkgs.alejandra;
            };
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
      trouble-nvim
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
        key = "<leader>gg";
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
    diagnostics = {
      virtual_lines = {
        only_current_line = true;
      };
      virtual_text = true;
    };
    autoCmd = [
      {
        event = [
          "BufWritePre"
        ];
        pattern = [
          "*"
        ];
        callback = {
          __raw = ''
            function(args) require("conform").format({ bufnr = args.buf }) end
          '';
        };
      }
      {
        command = "cd %:p:h";
        event = [
          "BufEnter"
        ];
      }
    ];
  };
}
