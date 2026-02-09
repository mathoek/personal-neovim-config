return {
    {
        "folke/trouble.nvim",
        opts = {
            icons = {}, -- Use empty table to suppress icons in v3
        },
        keys = {
            -- Your existing Diagnostics toggle
            {
                "<leader>tt",
                function() require("trouble").toggle("diagnostics") end,
                desc = "Trouble Diagnostics",
            },
            -- NEW: LSP References (replaces the standard 'gr')
            {
                "gr",
                function() require("trouble").toggle("lsp_references") end,
                desc = "LSP References (Trouble)",
            },
            -- NEW: Quickfix List toggle
            {
                "<leader>xq",
                function() require("trouble").toggle("quickfix") end,
                desc = "Quickfix List (Trouble)",
            },
            -- Navigation
            {
                "[t",
                function() require("trouble").next({ skip_groups = true, jump = true }) end,
                desc = "Next Trouble Item",
            },
            {
                "]t",
                function() require("trouble").prev({ skip_groups = true, jump = true }) end,
                desc = "Previous Trouble Item",
            },
        },
    },
}
