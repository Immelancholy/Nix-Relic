{
  pkgs,
  inputs,
  lib,
  ...
}: {
  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "kitty sh /home/mela/.local/share/bin/nv.sh";
      type = "Application";
      terminal = false;
      categories = ["Utility" "TextEditor"];
      icon = "nvim";
      mimeType = ["text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++"];
    };
  };

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
    withRuby = true;
    withPython3 = true;
    luaLoader.enable = true;
    plugins = {
      aerial = {
        enable = true;
        settings = {
          attach_mode = "global";
          backends = [
            "treesitter"
            "lsp"
            "markdown"
            "man"
          ];
          disable_max_lines = 5000;
          highlight_on_hover = true;
          ignore = {
            filetypes = [
              "gomod"
            ];
          };
        };
      };
      vim-be-good.enable = true;
      bullets = {
        enable = true;
        settings = {
          enable_in_empty_buffers = 0;
          enabled_file_types = [
            "markdown"
            "text"
            "gitcommit"
            "scratch"
          ];
          nested_checkboxes = 0;
        };
      };
      presence-nvim = {
        enable = true;
        enableLineNumber = true;
        fileAssets = {
          js = ["Javascript" "javascript"];
          ts = ["Typescript" "typescript"];
          rs = ["Rust" "https://www.rust-lang.org/logos/rust-logo-512x512.png"];
          go = ["Go" "https://go.dev/blog/go-brand/Go-Logo/PNG/Go-Logo_Aqua.png"];
          nix = ["Nix" "https://cdn.brandfetch.io/idXHqgWNOX/w/820/h/722/theme/dark/logo.png?c=1dxbfHSJFAPEGdCLU4o5B"];
        };
      };
      illuminate.enable = true;
      render-markdown.enable = true;
      refactoring.enable = true;
      blink-cmp = {
        enable = true;
        autoLoad = true;
        setupLspCapabilities = true;
        settings = {
          snippets = {
            preset = "luasnip";
          };
          sources = {
            default = [
              "lsp"
              "buffer"
              "path"
              "snippets"
            ];
            per_filetype = {
              text = [
                "lsp"
                "buffer"
                "path"
                "snippets"
                "dictionary"
                "spell"
              ];
              markdown = [
                "lsp"
                "buffer"
                "path"
                "snippets"
                "dictionary"
                "spell"
              ];
            };
            providers = {
              lsp = {
                name = "LSP";
                module = "blink.cmp.sources.lsp";
                fallbacks = [];
              };
              buffer = {
                name = "buffer";
                module = "blink.cmp.sources.buffer";
              };
              snippets = {
                name = "snippets";
                module = "blink.cmp.sources.snippets";
              };
              path = {
                name = "path";
                module = "blink.cmp.sources.path";
                async = true;
              };
              git = {
                name = "Git";
                module = "blink-cmp-git";
              };
              ripgrep = {
                async = true;
                module = "blink-ripgrep";
                name = "Ripgrep";
                score_offset = 100;
                opts = {
                  prefix_min_len = 3;
                  context_size = 5;
                  max_filesize = "1M";
                  project_root_marker = ".git";
                  project_root_fallback = true;
                  search_casing = "--ignore-case";
                  additional_rg_options = {};
                  fallback_to_regex_highlighting = true;
                  ignore_paths = {};
                  additional_paths = {};
                  debug = false;
                };
              };
              dictionary = {
                async = true;
                module = "blink-cmp-dictionary";
                name = "Dict";
                score_offset = 100;
                min_keyword_length = 3;
                # Optional configurations
                opts = {
                  dictionary_directories = {
                    __raw = ''{ vim.fn.expand("~/.config/nvim/dictionary/") }'';
                  };
                };
              };
              spell = {
                module = "blink-cmp-spell";
                name = "Spell";
                score_offset = 100;
                opts = {
                };
              };
            };
          };
          keymap = {
            preset = "default";
            "<S-Tab>" = [
              "snippet_backward"
              "fallback"
            ];
            "<Tab>" = [
              "snippet_forward"
              "fallback"
            ];

            "<Up>" = [
              "select_prev"
              "fallback"
            ];
            "<Down>" = [
              "select_next"
              "fallback"
            ];
            "<C-n>" = [
              "select_next"
              "fallback"
            ];
            "<C-p>" = [
              "select_prev"
              "fallback"
            ];
            "<C-y>" = [
              "select_and_accept"
            ];

            "<C-b>" = [
              "scroll_documentation_up"
              "fallback"
            ];
            "<C-f>" = [
              "scroll_documentation_down"
              "fallback"
            ];

            "<C-space>" = [
              "show"
              "show_documentation"
              "hide_documentation"
            ];
            "<C-e>" = [
              "hide"
              "fallback"
            ];
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
        };
      };
      obsidian = {
        enable = true;
        settings = {
          ui.enable = false;
          workspaces = [
            {
              name = "relationship";
              path = "~/obsidian/relationship";
            }
          ];
        };
      };
      blink-cmp-spell.enable = true;
      blink-cmp-dictionary.enable = true;
      blink-ripgrep.enable = true;
      blink-cmp-git = {
        enable = true;
        autoLoad = true;
      };
      blink-compat.enable = true;
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
      rustaceanvim = {
        enable = true;
        settings = {
          rustanalyzerPackafe = null;
          server = {
            cmd = [
              "/run/current-system/sw/bin/rust-analyzer"
            ];
            default_settings = {
              rust-analyzer = {
                check = {
                  command = "clippy";
                };
                inlayHints = {
                  lifetimeElisionHints = {
                    enable = "always";
                  };
                };
              };
            };
            standalone = false;
          };
        };
      };
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
                __unkeyed-1 = "<leader>tx";
                __unkeyed-2 = "<Cmd>Trouble diagnostics toggle<CR>";
                desc = "Diagnostics (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>tX";
                __unkeyed-2 = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
                desc = "Buffer Diagnostics (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>ts";
                __unkeyed-2 = "<cmd>Trouble symbols toggle focus=false<cr>";
                desc = "Symbols (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>tl";
                __unkeyed-2 = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
                desc = "LSP Definitions / references / ... (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>tL";
                __unkeyed-2 = "<cmd>Trouble loclist toggle<cr>";
                desc = "Location List (Trouble)";
              }
              {
                __unkeyed-1 = "<leader>tQ";
                __unkeyed-2 = "<cmd>Trouble qflist toggle<cr>";
                desc = "Quickfix List (Trouble)";
              }
            ];
          }
          {
            __unkeyed-1 = "harpoon";
            after = ''
              function()
                require("harpoon").setup()
              end
            '';
            dependencies = "plenary.nvim";
            keys = [
              {
                __raw = ''{ "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file", }'';
              }
              {
                __raw = ''{ "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", }'';
              }
              {
                __raw = ''{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", }'';
              }
              {
                __raw = ''{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", }'';
              }
              {
                __raw = ''{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", }'';
              }
              {
                __raw = ''{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", }'';
              }
              {
                __raw = ''{ "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", }'';
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
          css
          norg
          html
          rust
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
      # smear-cursor.enable = true;
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
              ""
              "⢰⡟⣡⡟⣱⣿⡿⠡⢛⣋⣥⣴⣌⢿⣿⣿⣿⣿⣷⣌⠻⢿⣿⣿⣿⣿⣿⣿"
              "⠏⢼⡿⣰⡿⠿⠡⠿⠿⢯⣉⠿⣿⣿⣿⣿⣿⣿⣷⣶⣿⣦⣍⠻⢿⣿⣿⣿"
              "⣼⣷⢠⠀⠀⢠⣴⡖⠀⠀⠈⠻⣿⡿⣿⣿⣿⣿⣿⣛⣯⣝⣻⣿⣶⣿⣿⣿"
              "⣿⡇⣿⡷⠂⠈⡉⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣍⡤⣤⣤⣤⡀⠀⠉⠛⠿"
              "⣿⢸⣿⡅⣠⣬⣥⣤⣴⣴⣿⣿⢿⣿⣿⣿⣿⣿⣟⡭⡄⣀⣉⡀⠀⠀⠀⠀"
              "⡟⣿⣿⢰⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣶⣦⣈⠀⠀⠀⢀⣶"
              "⡧⣿⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣾⣿"
              "⡇⣿⠃⣿⣿⣿⣿⣿⠛⠛⢫⣿⣿⣻⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿"
              "⡇⣿⠘⡇⢻⣿⣿⣿⡆⠀⠀⠀⠀⠈⠉⠙⠻⠏⠛⠻⣿⣿⣿⣿⣿⣭⡾⢁"
              "⡇⣿⠀⠘⢿⣿⣿⣿⣧⢠⣤⠀⡤⢀⣠⣀⣀⠀⠀⣼⣿⣿⣿⣿⣿⠟⣁⠉"
              "⣧⢻⠀⡄⠀⠹⣿⣿⣿⡸⣿⣾⡆⣿⣿⣿⠿⣡⣾⣿⣿⣿⣿⡿⠋⠐⢡⣶"
              "⣿⡘⠈⣷⠀⠀⠈⠻⣿⣷⣎⠐⠿⢟⣋⣤⣾⣿⣿⣿⡿⠟⣩⠖⢠⡬⠈⠀"
              "⣿⣧⠁⢻⡇⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⢀⠈⢀⡴⠈⠁⠀⠀"
              "⠻⣿⣆⠘⣿⠀⠀  ⠀⠈⠙⠛⠋⠉⠀⠀⠀⠀⡀⠤⠚⠁     "
              ""
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
                  __raw = "function(path) vim.cmd('cd ~/ | Telescope find_files') end";
                };
                desc = " Home";
                group = "diffChanged";
                key = "h";
              }
              {
                action = {
                  __raw = "function(path) vim.cmd('cd ~/Documents/Projects/ | Telescope find_files') end";
                };
                desc = " Projects";
                group = "Tag";
                key = "p";
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
                  __raw = "function(path) vim.cmd('cd ~/obsidian/ | Telescope find_files') end";
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
      #nvim-snippets.enable = true;
      lazygit = {
        enable = true;
        settings = {
          floating_window_use_plenary = 1;
        };
      };
      # cmp = {
      #   autoEnableSources = true;
      #   enable = true;
      #   settings = {
      #     sources = [
      #       {
      #         name = "nvim_lsp";
      #       }
      #       {
      #         name = "path";
      #       }
      #       {
      #         name = "buffer";
      #       }
      #       {
      #         name = "dictionary";
      #       }
      #       {
      #         name = "luasnip";
      #       }
      #     ];
      #   };
      # };
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
          marksman.enable = true;
          bashls.enable = true;
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
      harpoon2
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
      {
        action = "<Cmd>wqa<CR>";
        key = "ZZ";
        mode = ["n"];
      }
      {
        action = "<Cmd>BufferClose<CR>";
        key = "<leader>bx";
        mode = ["n"];
      }
      {
        action = "<Cmd>BufferNext<CR>";
        key = "<leader>bn";
        mode = ["n"];
      }
      {
        action = "<Cmd>BufferPrevious<CR>";
        key = "<leader>bp";
        mode = ["n"];
      }
      {
        action = "<Cmd>BufferCloseAllButCurrent<CR>";
        key = "<leader>bc";
        mode = ["n"];
      }
      {
        action = "<cmd>BufferGoto 1<cr>";
        key = "<leader>b1";
        mode = ["n"];
      }
      {
        action = "<cmd>BufferGoto 2<cr>";
        key = "<leader>b2";
        mode = ["n"];
      }
      {
        action = "<cmd>BufferGoto 3<cr>";
        key = "<leader>b3";
        mode = ["n"];
      }
      {
        action = "<cmd>BufferGoto 4<cr>";
        key = "<leader>b4";
        mode = ["n"];
      }
      {
        action = "<cmd>BufferGoto 5<cr>";
        key = "<leader>b5";
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
  xdg.configFile."nvim/dictionary" = {
    source = ./dictionary;
  };
}
