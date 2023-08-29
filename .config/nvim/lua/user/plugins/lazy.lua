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
    "numToStr/Comment.nvim", -- <gc> line comments, <gb> block comments
    "tpope/vim-fugitive",    -- Git wrapper for vim. Prefix :Git
    "tpope/vim-surround",    -- Surrounding pairs. cs"' ysiw] ysWfprint
    "mbbill/undotree",       -- Undo History :UndoTreeToggle

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
        },
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "saadparwaiz1/cmp_luasnip" },  -- Snipper completion source
            { "hrsh7th/cmp-buffer" },        -- Buffer completion source
            { "hrsh7th/cmp-nvim-lsp" },      -- LSP completion source
        },
    },          -- Completion engine
    -- Snippet engine (required for nvim-cmp)
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    -- Formatting / Linting
    "mhartington/formatter.nvim",
    "mfussenegger/nvim-lint",

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() require('nvim-treesitter.install').update({
                with_sync = true
            }) end,
    },

    -- Colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua" },
    },

})

