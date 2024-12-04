local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

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

if vim.fn.findfile("package.json", ".;") or not (vim.fn.findfile("deno.json", ".;") or vim.fn.findfile("deno.jsonc", ".;")) then
    lspconfig.volar.setup{
        init_options = {
            typescript = {
                serverPath = "~/.config/yarn/global/node_modules/typescript/lib/tsserverlibrary.js"
            }
        },
        capabilities = capabilities,
        filetypes = {'vue'},
        on_attach = function()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
            vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
            vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer=0})
            vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
            vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
            vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
        end,
    }

    lspconfig.ts_ls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json"),
    }
end

if vim.fn.findfile("deno.json") or vim.fn.findfile("deno.jsonc") then

    lspconfig.denols.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    }

end
