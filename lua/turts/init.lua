local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local set = vim.opt
local StoveGroup = augroup('TheOriginalStove', {})

require("turts._remaps")
require("turts._cmp")
require("turts._debugger")
require("turts._dockerlsp")
require("turts._golsp")
require("turts._lua_lsp")
require("turts._project")
require("turts._telescope")
require("turts._terraformlsp")
require("turts._todo")
require("turts._tsserver")
require("turts._templ")
require("turts._volar")


require("lualine").setup{
    options = {
        icons_enabled = true,
        theme = 'everforest'
    }
}

autocmd({"FileType"}, {
    group = StoveGroup,
    pattern = "js,tsx,jsx,vue,html,ts,toml",
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
        vim.opt.expandtab = true
    end
})

require("mason").setup()

vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

require'nvim-treesitter'.setup {}
require'nvim-treesitter'.install { 'go', 'rust', 'javascript', 'typescript', 'zig', 'python', 'lua' }

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'rust', 'javascript', 'typescript', 'zig', 'python', 'lua' },
    callback = function() vim.treesitter.start() end,
})
