local action_state = require('telescope.actions.state') -- runtime
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

--- Dropdown-like theme with prompt/results on top and preview below.
--- Results are capped at ~10 lines; preview fills the remaining space.
local function get_dropdown_mirror(opts)
    local theme_opts = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
            mirror = true,
            width = 85,
            height = 0.9,
            preview_cutoff = 1,
            -- results = height - preview_height - prompt(1) - h_space(6 with borders)
            -- For ~10 result lines: preview = height - 10 - 1 - 6
            preview_height = function(_, _, layout_height)
                return math.max(5, layout_height - 17)
            end,
        },
        border = true,
        borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
    }
    return vim.tbl_deep_extend("force", theme_opts, opts or {})
end

require('telescope').setup{
    defaults = {
        prompt_prefix = "🔍: ",
        layout_config = {
            vertical = { width = 0.65, height = 0.9 },
        },
        file_sorter = require("telescope.sorters").get_fzf_sorter,
        color_devicons = true,
        mappings = {
            ["i"] = {
                ["<c-a>"] = function() print(vim.inpsect(action_state.get_selected_entry())) end
            },
        },
    },
    pickers = {
        file_browser = get_dropdown_mirror(),
        find_files = get_dropdown_mirror(),
        live_grep = get_dropdown_mirror(),
        lsp_document_symbols = get_dropdown_mirror(),
        lsp_code_actions = get_dropdown_mirror(),
        lsp_references = get_dropdown_mirror(),
        diagnostics = get_dropdown_mirror(),
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("dap")
