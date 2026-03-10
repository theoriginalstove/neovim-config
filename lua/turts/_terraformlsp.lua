local on_attach = require('turts.utils').on_attach

vim.lsp.config('terraformls', {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    capabilities = vim.lsp.protocol.make_client_capabilities()
})
vim.lsp.enable('terraformls')
