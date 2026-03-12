local on_attach = require('turts.utils').on_attach

local ok, cap = pcall(require, "cmp_nvim_lsp")
if not ok then
    return
end

local capabilities = cap.default_capabilities()

vim.lsp.config('ts_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.enable('ts_ls')
