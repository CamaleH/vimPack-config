local opt = vim.opt

local function should_use_system_clipboard()
	return not (vim.env.SSH_CONNECTION or vim.env.SSH_TTY or vim.env.SSH_CLIENT)
end

opt.cursorline = true
if should_use_system_clipboard() then
	opt.clipboard = "unnamedplus"
end
opt.colorcolumn = "100"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local indent = 2
opt.smartindent = true
opt.shiftwidth = indent
opt.tabstop = indent
opt.shiftround = true
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true
vim.opt.termguicolors = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
