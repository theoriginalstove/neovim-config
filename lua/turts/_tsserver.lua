local u = require("turts.utils")
local lspconfig = require("lspconfig")
local get_on_attach = require("turts.utils").get_on_attach

local ok, cap = pcall(require, "cmp_nvm_lsp")
if not ok then
    return
end

local capabilities = cap.default_capabilities()

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr,mode, lhs, rhs, opts or {
        silent = true,
    })
end

local on_attach = get_on_attach(client, bufnr, {
    buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
})

lspconfig.tsserver.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
