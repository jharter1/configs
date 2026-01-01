-- Core Neovim options
local opt = vim.opt

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
opt.laststatus = 3
opt.termguicolors = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true

-- Editing
opt.clipboard = "unnamedplus"
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Search
opt.ignorecase = true
opt.smartcase = true
