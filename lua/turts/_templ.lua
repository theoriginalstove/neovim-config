local lspconfig = require("lspconfig")
-- install gopls with `go install golang.org/x/tools/gopls@latest
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
    vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.lsp.config('templ', {})
vim.lsp.config('html', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})


vim.lsp.config('htmx', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "htmx" },
})

vim.lsp.config('tailwindcss', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "astro", "templ", "javascript", "typescript", "react" },
})
vim.lsp.config('yamlls', {
    on_attach = on_attach,
    settings = {
        yaml = {
            validate = true,
            hover = true,
            format = {
                enable = true,
                singleQuote = true
            },
            schemaStore = {
                url = "https://www.schemastore.org/api/json/catalog.json"
            },
            schemas = {
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*/.gitlab-ci.yml",
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/home/turts/devops/ci-templates/*",
            },
        },
        redhat = {
            telemetry = {
                enabled = false
            }
        }
    },
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = {
        "yaml", "yml", "bu"
    }
})

vim.lsp.enable('yamlls')
