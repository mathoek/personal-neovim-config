return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        cache = false, -- REQUIRED to use functions in on_highlights
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        -- This must be outside of 'styles' but inside the main setup braces
        on_highlights = function(hl, c)
          -- 1. Fix f-strings (Keep these orange)
          hl.Special = { fg = c.orange }
          hl["@punctuation.special.python"] = { fg = c.orange }
          
          -- 2. Variables (Set to Cyan/Blue for that VS Code feel)
          hl["@variable.python"] = { fg = c.cyan } 
          hl["@interpolation.python"] = { fg = c.cyan } -- Inside f-strings
          
          -- 3. Functions (Set to Yellow)
          hl["@function.python"] = { fg = c.yellow }
          hl["@function.builtin.python"] = { fg = c.yellow }
          
          -- 4. Constants (Set to Magenta/Purple)
          hl["@constant.python"] = { fg = c.magenta }
          hl["@boolean.python"] = { fg = c.magenta }
          
          -- 5. Decorators (The @symbol)
          hl["@attribute.python"] = { fg = c.green }
        end,      })

      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
      },
    },
  },
}
