local on_attach = require('turts.utils').on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('rls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        unstable_features = true,
        build_on_save = false,
        all_features = true,
    }
})

vim.lsp.config('rust_analyzer', {
    on_attach = on_attach,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
            }
        }
    }
})

vim.lsp.enable('rls')
vim.lsp.enable('rust_analyzer')
