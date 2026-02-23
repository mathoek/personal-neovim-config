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
	-- 1. Enable the 2-way binding between Neovim's CWD and Neo-tree's root
        bind_to_cwd = true, 
        -- 2. Tell it to update the global working directory (not just the current window/tab)
        cwd_target = {
          sidebar = "global", 
          current = "global"
        },
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
	  ["T"] = "open_terminal"
        },
      },
    commands = {
        open_terminal = function(state)
          local node = state.tree:get_node()
          if not node then return end
          local path = node.path
          if node.type ~= "directory" then
            path = vim.fn.fnamemodify(path, ":h")
          end
          -- Safely escape the path for the shell (handles spaces, quotes, etc.)
          local safe_path = vim.fn.shellescape(path)
          -- Use ToggleTerm's direct Lua API instead of a string command
          -- Syntax: exec(command, terminal_id, size, direction)
          require("toggleterm").exec("cd " .. safe_path, 1, nil, "horizontal")
        end,
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
