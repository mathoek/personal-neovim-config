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
          if not node or not node.path then return end
          
          local path = node.path
          if node.type ~= "directory" then
            path = vim.fn.fnamemodify(path, ":h")
          end
          
          -- Normalize slashes for Windows
          path = path:gsub("\\", "/")
          
          local term_manager = require("toggleterm.terminal")
          local term = term_manager.get(1)
          
          if term then
            -- Terminal #1 already exists. Make sure it is visible, then send 'cd'
            if not term:is_open() then
              term:toggle()
            end
            term:send('cd "' .. path .. '"')
          else
            -- Terminal #1 does not exist. Create it natively rooted in the path.
            local new_term = term_manager.Terminal:new({
              id = 1,
              dir = path,
              direction = "horizontal",
            })
            new_term:toggle()
          end
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
	    window = {
		position = "float",
		mappings = {
		    ["A"] = "git_add_all",
		    ["gu"] = "git_unstage_file",
		    ["gU"] = "git_undo_last_commit",
		    ["ga"] = "git_add_file",
		    ["gt"] = "git_toggle_file_stage",
		    ["gr"] = "git_revert_file",
		    ["gc"] = "git_commit",
		    ["gp"] = "git_push",
		    ["gg"] = "git_commit_and_push",
		    ["o"] = {
			"show_help",
			nowait = false,
			config = { title = "Order by", prefix_key = "o" },
		    },
		    ["oc"] = { "order_by_created", nowait = false },
		    ["od"] = { "order_by_diagnostics", nowait = false },
		    ["om"] = { "order_by_modified", nowait = false },
		    ["on"] = { "order_by_name", nowait = false },
		    ["os"] = { "order_by_size", nowait = false },
		    ["ot"] = { "order_by_type", nowait = false },
		},
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
          },
        },
      },
    },
  }
}}
