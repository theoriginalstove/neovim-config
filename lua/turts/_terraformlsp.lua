vim.lsp.config('terraformls', {
    flags = { debounce_text_changes = 150 },
    capabilities = vim.lsp.protocol.make_client_capabilities()
})
vim.lsp.enable('terraformls')
