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
        cypher = "cypher",
    }
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- perm / permify
vim.treesitter.language.register('perm', 'perm')
parser_config.perm = {
  install_info = {
    url = 'https://github.com/theoriginalstove/tree-sitter-perm', -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
}

-- cypher
vim.treesitter.language.register('cypher', 'cypher')
parser_config.cypher = {
    install_info = {
        url = '~/code/tree-sitter-cypher',
        files = { "src/parser.c", "src/scanner.c" },
    },
}
