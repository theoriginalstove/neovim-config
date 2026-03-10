local on_attach = require('turts.utils').on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('volar', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
    root_markers = {"deno.json", "deno.jsonc", "deno.lock", "package.json"},
})

vim.lsp.config('denols', {
    on_attach = on_attach,
    root_markers = {"deno.json", "deno.jsonc", "deno.lock", "package.json"},
})

vim.lsp.enable('volar')
vim.lsp.enable('denols')
