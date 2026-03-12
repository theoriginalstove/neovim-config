local on_attach = require('turts.utils').on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('cssls', {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable('cssls')
