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

-- =====================================================================
-- PowerShell Integration Fix for Windows
-- =====================================================================
-- Check if PowerShell Core (pwsh) is installed, otherwise use standard powershell
local shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

vim.opt.shell = shell
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""