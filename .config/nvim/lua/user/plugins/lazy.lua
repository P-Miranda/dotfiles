-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
return require('lazy').setup({
    -- My plugins here

    -- Add new plugins here
    -- "numToStr/Comment.nvim", -- <gc> line comments, <gb> block comments
    -- "mbbill/undotree",       -- Undo History :UndoTreeToggle
    --
    -- {                        -- Collection of various small independent plugins/modules
    --     'echasnovski/mini.nvim',
    --     config = function()
    --         require('mini.ai').setup { n_lines = 500 } -- around/inside objects
    --         require('mini.surround').setup()           -- Surround pairs. sd' sr)'
    --     end,
    -- },

    -- { -- Adds git related signs to the gutter, :Gitsigns <command>
    --     'lewis6991/gitsigns.nvim',
    --     opts = {
    --         signs = {
    --             add = { text = '+' },
    --             change = { text = '~' },
    --             delete = { text = '_' },
    --             topdelete = { text = '‾' },
    --             changedelete = { text = '~' },
    --         },
    --     },
    -- },

    -- Telescope (plus Extentions)
    -- Notes: install ripgrep and fd for live-grep support
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'saghen/blink.cmp',
        },
    },

    -- Completion
    {
        "saghen/blink.cmp",
        event = "VimEnter",
        version = '1.*',
        build = "cargo build --release",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "giuxtaposition/blink-cmp-copilot",
        },
        opts = {
            keymap = { preset = 'default' },
            sources = {
                default = { 'lsp', 'snippets', 'copilot', 'buffer', 'path'},
                providers = {
                    copilot = {
                        name = 'copilot',
                        module = 'blink-cmp-copilot',
                        score_offset = -2, -- snippets > copilot > buffer
                        async = true,
                    },
                    path = { score_offset = -4 } -- buffer > path
                },
            },
            completion = { menu = { draw = { columns = { { "label", "label_description", gap = 1 }, { "kind" } }}}},
        },
        snippets = { preset = 'luasnip' },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        signature = { enabled = true },

    },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         { "saadparwaiz1/cmp_luasnip" },  -- Snipper completion source
    --         { "hrsh7th/cmp-buffer" },        -- Buffer completion source
    --         { "hrsh7th/cmp-nvim-lsp" },      -- LSP completion source
    --     },
    -- },          -- Completion engine
    -- -- Snippet engine (required for nvim-cmp)
    -- "L3MON4D3/LuaSnip",
    -- "rafamadriz/friendly-snippets",

    -- Formatting / Linting
    -- "mhartington/formatter.nvim",
    { -- Formatting
        'stevearc/conform.nvim',
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>fm',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            formatters_by_ft = {
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
                c = { "clang-format" },
                cpp = { "clang-format" },
                verilog = { "verible" },
            },
        },
    },
    -- "mfussenegger/nvim-lint",

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
        lazy = false,
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { "bash", "c", "cpp", "latex", "lua", "make", "markdown", "markdown_inline", "python", "verilog", "yaml" },
            sync_install = true,
            auto_install = false,
            -- disable for large files
            -- disable = function(lang, buf)
            --     local max_filesize = 100 * 1024 -- 100 KB
            --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --     if ok and stats and stats.size > max_filesize then
            --         return true
            --     end
            -- end,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },

    -- Colorscheme
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     lazy = false,
    -- },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     dependencies = { "copilot.lua" },
    -- },
    --

})
