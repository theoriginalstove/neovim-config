-- Leader key must be set before lazy.nvim loads plugins
vim.g.mapleader = " "

--------------------------------------
-- General settings
--------------------------------------
vim.opt.mouse = "a"
vim.opt.exrc = true
vim.opt.guicursor = "a:block"
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.encoding = "UTF-8"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.colorcolumn = "0"
vim.opt.list = true
vim.opt.listchars = { trail = "·", precedes = "«", extends = "»", tab = "▸▸" }

vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "yellow" })

-- Ignore files
vim.opt.wildignore:append({ "*.pyc", "*_build/*", "**/coverage/*", "**/node_modules/*", "**/.git/*" })

--------------------------------------
-- Bootstrap lazy.nvim
--------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("turts.plugins")

--------------------------------------
-- Load user configuration
--------------------------------------
require("turts")
