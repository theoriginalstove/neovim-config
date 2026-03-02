local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('cssls', {
    capabilities = capabilities,
})
vim.lsp.enable('cssls')
