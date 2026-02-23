return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "folke/snacks.nvim",
    },
    keys = {
      -- De hoofdactie: Directe toggle
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Toggle)" },
      -- Extra opties onder de hoofdletter 'E' (geen conflict met kleine 'e')
      { "<leader>Ef", "<cmd>Neotree float<cr>", desc = "Floating Explorer" },
      { "<leader>Er", "<cmd>Neotree reveal<cr>", desc = "Reveal Current File" },
      { "<leader>Eb", "<cmd>Neotree buffers<cr>", desc = "Buffer Explorer" },
      { "<leader>Eg", "<cmd>Neotree git_status<cr>", desc = "Git Explorer" },
      -- Nieuwe actie: Overzicht van functies en klassen in het huidige bestand
      { "<leader>Es", "<cmd>Neotree document_symbols<cr>", desc = "Document Symbols" },
    },
    opts = {
      close_if_last_window = true, -- Sluit Neovim als Neo-tree het enige venster is
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      -- Expliciet de bronnen definiëren
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols", 
      },

      -- Configuratie voor de symbolen (functies, klassen, etc.)
      document_symbols = {
        follow_cursor = true, -- Selecteer automatisch het symbool waar je cursor staat
        client_filters = "first",
        renderers = {
          root = {
            {"indent"},
            {"icon", default="C" },
            {"name", zindex = 10},
          },
          symbol = {
            {"indent", with_expanders = true},
            {"kind_icon", default="?" },
            {"container",
              content = {
                {"name", zindex = 10},
                {"kind_name", zindex = 20, align = "right"},
              }
            }
          },
        }
      },

      filesystem = {
	  hijack_netrw_behavior = "open_default", -- "open_default", "disabled", or "open_current"
        filtered_items = {
          visible = false, -- Toon verborgen bestanden niet standaard
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            "node_modules",
          },
        },
        follow_current_file = {
          enabled = true, -- Focus het huidige bestand in de boomstructuur
        },
        use_libuv_file_watcher = true, -- Update automatisch bij wijzigingen
      },

      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = "none", -- Deactiveer standaard space mapping
          ["l"] = "open",       -- Gebruik 'l' om te openen (HJKL stijl)
          ["h"] = "close_node", -- Gebruik 'h' om in te klappen
          ["P"] = { "toggle_preview", config = { use_float = true } },
	  ["s"] = "open_vsplit",  -- Opens file in a vertical split
	  ["S"] = "open_split",   -- Opens file in a horizontal split
	  ["t"] = "open_tabnew",  -- Opens file in a new tab
        },
      },

      default_component_configs = {
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          indent_size = 2,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          default = "*",
          highlight = "NeoTreeFileIcon"
        },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁔",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          }
        },
      },
    },
  }
}
