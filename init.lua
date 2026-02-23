require('config.options')
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require('config.lazy')
require('config.keybindings')
vim.opt.clipboard = "unnamedplus"
local is_windows = vim.loop.os_uname().version:match("Windows")
if is_windows then
    -- Windows specific settings
    vim.opt.shell = "powershell.exe"
else
    vim.g.clipboard = "xclip"
end

