local on_attach = require('turts.utils').on_attach

vim.lsp.config('dockerls', { on_attach = on_attach })
vim.lsp.enable('dockerls')

local function set_filetype(pattern, filetype)
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = pattern,
        command = "set filetype=" .. filetype,
    })
end

set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")

vim.lsp.enable('dockercompose',{
    default_config = {
        cmd = {"compose-language-service", "--stdio" },
        filetypes = {"yaml.dockercompose"},
    }
})
