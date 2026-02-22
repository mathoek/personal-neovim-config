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
    },
    opts = {
      close_if_last_window = true, -- Sluit Neovim als Neo-tree het enige venster is
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      filesystem = {
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
