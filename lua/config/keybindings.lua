vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = 'Go to curr directory'})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>pr", function()
  -- 1. Get the full path to the current file
  local file = vim.fn.expand("%:p")
  --  2. save the file
  vim.cmd("write")

  -- 3. "Shellescape" it (automatically wraps it in quotes for the shell)
  local cmd_string = "python3 " .. vim.fn.shellescape(file)
  
  -- 4. Send directly to Toggle
  -- The arguments are: cmd, id, size, dir, direction
  require("toggleterm").exec(cmd_string, 1, nil, nil, "float")

end, { desc = "Run python file" })   
vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>Q", ":qa<CR>", { desc = "Close all buffers" })
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical split" })


