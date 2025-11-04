local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local get_on_attach = require('turts.utils').get_on_attach

local on_attach = get_on_attach(client, bufnr, {})
local lspconfig = require("lspconfig")

lspconfig.eslint.setup{}

lspconfig.lua_ls.setup{
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
}

lspconfig.buf_ls.setup{
    on_attach = on_attach,
}

lspconfig.sourcekit.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

lspconfig.kotlin_language_server.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {"kotlin", "kt", "kts"},
    cmd = { "/opt/homebrew/bin/kotlin-lsp" },
}

lspconfig.zls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_dir = lspconfig.util.root_pattern("build.zig", ".git") or vim.loop.cwd,
    single_file_support = true,
}

