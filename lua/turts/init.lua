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
        theme = 'auto'
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

-- Theme setup. Reads $XDG_STATE_HOME/theme-mode (auto|light|dark);
-- in auto mode, picks light during the day and dark otherwise.
local state_dir = os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")
local state_path = state_dir .. "/theme-mode"

local function read_mode()
    local f = io.open(state_path, "r")
    if not f then return "auto" end
    local m = (f:read("*l") or ""):gsub("%s+", "")
    f:close()
    if m == "light" or m == "dark" then return m end
    return "auto"
end

local function set_theme()
    local mode = read_mode()
    local bg
    if mode == "light" or mode == "dark" then
        bg = mode
    else
        local hour = tonumber(os.date("%H"))
        bg = (hour >= 7 and hour < 18) and "light" or "dark"
    end
    require("gruvbox").setup({
        dim_inactive = true,
        contrast = "hard",
    })
    vim.o.background = bg
    vim.cmd("colorscheme gruvbox")
end

set_theme()

-- Re-evaluate every 30 minutes (covers the auto-mode day/night rollover).
vim.fn.timer_start(1800000, function()
    set_theme()
end, { ["repeat"] = -1 })

-- Watch the state directory so manual toggles apply instantly.
vim.fn.mkdir(state_dir, "p")
local watcher = vim.uv.new_fs_event()
if watcher then
    watcher:start(state_dir, {}, vim.schedule_wrap(function(err, fname)
        if not err and fname == "theme-mode" then set_theme() end
    end))
end
