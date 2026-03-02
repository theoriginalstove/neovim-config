local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local get_on_attach = require('turts.utils').get_on_attach

local on_attach = get_on_attach(client, bufnr, {})

vim.lsp.config('eslint', {})

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
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

vim.lsp.config('buf_ls', {
    on_attach = on_attach,
})

vim.lsp.config('sourcekit', {
    capabilities = capabilities,
    on_attach = on_attach
})

vim.lsp.config('kotlin_language_server', {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {"kotlin", "kt", "kts"},
    cmd = { "/opt/homebrew/bin/kotlin-lsp" },
})

vim.lsp.config('zls', {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    single_file_support = true,
})

