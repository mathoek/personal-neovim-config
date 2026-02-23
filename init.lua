require('config.options')
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require('config.lazy')
require('config.keybindings')
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = "xclip"
