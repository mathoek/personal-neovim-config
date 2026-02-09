return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        -- The key to open/close the terminal
        open_mapping = [[<c-\>]],

        -- Appearance: 'float', 'vertical', 'horizontal'
        direction = "float",

        float_opts = {
          border = "curved",
        },
      })
    end,
  }
}
