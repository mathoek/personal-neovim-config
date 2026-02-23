return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 1. Your Custom Block Logo
    local header_text = {
      [[░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░  ]],
      [[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
      [[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
      [[░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
      [[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
      [[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
      [[░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
      [[                                                                               ]],
    }
    dashboard.section.header.val = header_text

    -- 2. Define your gradient colors (Top to bottom: Blue fading into Purple)
    local gradient_colors = {
      "#7aa2f7", -- Top line
      "#8794f3",
      "#9586ef",
      "#a277eb",
      "#b069e7",
      "#be5ae3",
      "#cb4bdf", -- Bottom line
      "#cb4bdf", -- Empty spacing line
    }

    -- 3. Automatically create highlights and map them to each line
    local header_hls = {}
    for i, color in ipairs(gradient_colors) do
      local hl_name = "AlphaHeaderGradient" .. i
      -- Create the highlight group in Neovim
      vim.api.nvim_set_hl(0, hl_name, { fg = color })
      -- Tell Alpha to apply this highlight to the entire line (0 to -1)
      table.insert(header_hls, { { hl_name, 0, -1 } })
    end
    
    dashboard.section.header.opts.hl = header_hls

    -- 4. Quick Access Menu Buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file",            "<cmd>Telescope find_files<CR>"),
      dashboard.button("g", "󰊢  Find text (Live Grep)", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("r", "  Recent files",         "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("t", "󰙅  File Explorer",        "<cmd>Neotree focus<CR>"), 
      dashboard.button("u", "󰒲  Update plugins",       "<cmd>Lazy update<CR>"),
      dashboard.button("q", "󰅚  Quit NVIM",            "<cmd>qa<CR>"),
    }

    -- 5. Footer showing loaded plugins
    local function footer()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
    end
    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "Comment"

    -- 6. Layout assembly
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
  end,
}
