return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- REQUIRED by the README
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- 1. Setup the directory as per README
      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- 2. Install the 'brains' for Python
      ts.install({ "python", "lua", "vim", "vimdoc" })

      -- 3. The "VS Code" Magic: Enable Highlighting manually via Autocmd
      -- This is the method recommended in the new README section 'Highlighting'
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "lua" },
        callback = function()
          vim.treesitter.start()
        end,
      })

      -- 4. Enable VS Code-style Indentation
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
