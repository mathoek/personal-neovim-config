return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Setup Mason (The installer)
      require("mason").setup()

      -- 2. Setup Mason-LSPConfig & The Language Server
      require("mason-lspconfig").setup({
        -- List of servers to automatically install
        ensure_installed = {
            "pyright", -- Python
            "lua_ls",  -- Lua
        },

        -- AUTOMATIC SETUP HANDLER
        -- This replaces the incompatible 'setup_handlers' call
	handlers = {
          function(server_name)
            -- 1. Create the capabilities for nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- 2. Pass them to the server setup
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },
}
