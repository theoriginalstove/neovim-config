local on_attach = require('turts.utils').on_attach
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('eslint', { on_attach = on_attach })

vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'./luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        })
    end,
    settings = {
        Lua = {}
    }
})

vim.lsp.config('buf_ls', { on_attach = on_attach })

vim.lsp.config('sourcekit', {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config('kotlin_language_server', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"kotlin", "kt", "kts"},
    cmd = { "/opt/homebrew/bin/kotlin-lsp" },
})

vim.lsp.config('zls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    single_file_support = true,
})

vim.lsp.enable('eslint')
vim.lsp.enable('lua_ls')
vim.lsp.enable('buf_ls')
vim.lsp.enable('sourcekit')
vim.lsp.enable('kotlin_language_server')
vim.lsp.enable('zls')
