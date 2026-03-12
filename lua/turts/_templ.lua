local on_attach = require('turts.utils').on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.templ",
    callback = function() vim.lsp.buf.format() end,
})

vim.lsp.config('templ', { on_attach = on_attach })
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

vim.lsp.enable('templ')
vim.lsp.enable('html')
vim.lsp.enable('htmx')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('yamlls')
