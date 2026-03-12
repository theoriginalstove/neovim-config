-- install gopls with `go install golang.org/x/tools/gopls@latest
local on_attach = require('turts.utils').on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function() Goimports(1000) end,
})

vim.lsp.config('gopls',{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            gofumpt = true,
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
    init_options = {
        usePlaceholders = true,
    }
})

function Goimports(timeoutms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
    vim.lsp.buf.format({async = true})
end


-- apparently this causes issues with saving
--lspconfig.golangci_lint_ls.setup{}
--

vim.lsp.enable('gopls')
