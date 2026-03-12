M = {}

function M.on_attach(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded", max_width = 100, max_height = 20 })
    end, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", opts)
    vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
end

return M
