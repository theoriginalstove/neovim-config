require'nvim-treesitter.configs'.setup{
    -- ensure_installed = { "javascript", "go", "python", "css", "json", "vue", "yaml", "tsx", "typescript" },
    sync_installed = true,
    highlight = {
        enable = true,
    },
    autotag = {
        enable = true,
        filetypes = {"html","xml","vue","jsx","tsx"},
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        }, 
        highlight_current_scopes = {
            enable = true,
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
    },
}
vim.filetype.add({
    extension = {
        perm = "perm",
    }
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

vim.treesitter.language.register('perm','perm')
parser_config.perm = {
    install_info = {
        url = "https://github.com/theoriginalstove/tree-sitter-perm",
        files = {"src/parser.c"},
        branch = "main"
    }
}

require'treesitter-context'.setup{}
