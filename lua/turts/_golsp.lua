
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
-- install gopls with `go install golang.org/x/tools/gopls@latest
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
    vim.keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", {buffer=0})
    vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", {buffer=0})
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
    vim.cmd('au BufWritePre *.go lua Goimports(1000)')
    vim.cmd('au BufWritePre *.go lua vim.lsp.buf.format({ async = true })')

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
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
}

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

if not configs.golang_lint_ls then
    configs.golangci_lint_ls = {
        default_config = {
            cmd = {'golangci-lint-langserver'},
            root_dir = lspconfig.util.root_pattern('.git','go.mod'),
            init_options = {
                command = {"golangci-lint","run","--out-format","json"}
            }
        }
    }
end


-- apparently this causes issues with saving
--lspconfig.golangci_lint_ls.setup{}
--

