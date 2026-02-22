return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        -- We definiëren alleen de groepen en iconen
        { "<leader>e", icon = "󰙅 " }, -- Dit is je toggle
        { "<leader>E", group = "Explorer Extra", icon = "󰒓 " }, -- Dit is je menu
        { "<leader>f", group = "Find (Snacks)", icon = "󰈞 " },
        { "<leader>g", group = "Git", icon = "󰊢 " },
        { "<leader>b", group = "Buffers", icon = "󰓩 " },
	[ "<leader>p", group = "Python" , icon = ""},
      },
      win = { border = "rounded" },
    },
  },
}
