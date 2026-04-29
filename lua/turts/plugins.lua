return {
    -- Icons
    { "ryanoasis/vim-devicons" },
    { "kyazdani42/nvim-web-devicons" },

    -- Git
    { "airblade/vim-gitgutter" },
    { "f-person/git-blame.nvim" },
    { "sindrets/diffview.nvim" },

    -- Undo
    { "mbbill/undotree" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "nvim-treesitter/nvim-treesitter-locals" },
    { "windwp/nvim-ts-autotag" },

    -- LSP
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },

    -- Completion (nvim-cmp ecosystem)
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-omni" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "onsails/lspkind-nvim" },

    -- Telescope
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },

    -- Todo comments
    { "folke/todo-comments.nvim" },

    -- TypeScript
    { "jose-elias-alvarez/nvim-lsp-ts-utils" },

    -- Project workspace
    { "theoriginalstove/project.nvim" },

    -- Statusline and bufferline
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/bufferline.nvim", version = "v2.*" },

    -- Debugger
    { "mfussenegger/nvim-dap" },
    { "leoluz/nvim-dap-go" },

    -- AI completion
    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
    },

    -- Test framework
    { "antoinemadec/FixCursorHold.nvim" },
    { "nvim-neotest/neotest" },
    { "nvim-neotest/neotest-go" },

    -- Autopairs
    { "windwp/nvim-autopairs" },

    -- Editorconfig
    { "gpanders/editorconfig.nvim" },

    -- Pkl support
    { "apple/pkl-neovim" },

    -- Colorizer
    { "norcalli/nvim-colorizer.lua" },

    -- Custom tree-sitter parser
    { "theoriginalstove/tree-sitter-perm" },

    -- Themes
--    {
--        "sainnhe/gruvbox-material",
--        priority = 1000,
--        config = function()
--            vim.opt.background = "dark"
--            vim.g.gruvbox_material_contrast_light = 'hard'
--            vim.cmd.colorscheme("gruvbox-material")
--        end,
--    },
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    { "lifepillar/vim-solarized8", branch = "neovim" },
    { "savq/melange-nvim" },
    { "rebelot/kanagawa.nvim" },
    { "neanias/everforest-nvim" },

    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
    -- lsp enhancements:
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded",
            }
        }
    },

    -- Datadog gutter signs (local plugin)
--    {
--        dir = "~/code/datadog.nvim",
--        name = "datadog.nvim",
--        main = "datadog",
--        event = "BufReadPost",
--        cmd = { "DatadogRefresh", "DatadogHover" },
--        opts = {
--            -- service = "my-service",
--            -- env = "prod",
--        },
--        keys = {
--            { "<leader>dd", "<cmd>DatadogHover<cr>",   desc = "Datadog: event at cursor" },
--            { "<leader>dr", "<cmd>DatadogRefresh<cr>", desc = "Datadog: refresh signs" },
--        },
--    },
}
