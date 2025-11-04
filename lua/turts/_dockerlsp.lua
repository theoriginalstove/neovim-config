local get_on_attach = require('turts.utils').get_on_attach

local on_attach = get_on_attach(client, bufnr, {})
local lspconfig = require('lspconfig')

lspconfig.dockerls.setup{
    on_attach = on_attach,
}

local function set_filetype(pattern, filetype)
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = pattern,
        command = "set filetype=" .. filetype,
    })
end

set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")


vim.lsp.enable('dockercompose',{
    default_config = {
        on_attach = on_attach,
        cmd = {"compose-language-service", "--stdio" },
        filetypes = {"yaml.dockercompose"},
    }
})
