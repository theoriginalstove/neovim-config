local action_state = require('telescope.actions.state') -- runtime 
local builtin = require('telescope.builtin')

require('telescope').setup{
    defaults = {
        prompt_prefix = "🔍 ",
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        color_devicons = true,
        mappings = {
            ["i"] = {
                ["<c-a>"] = function() print(vim.inpsect(action_state.get_selected_entry())) end
            },
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
            theme = "ivy",
        },
    },
}

require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("dap") 

local on_attach = function(client, bufnr) 
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer=0})
        vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
        vim.keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", {buffer=0})
        vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", {buffer=0})
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
end

require("sg").setup {
    on_attach = on_attach,
}
