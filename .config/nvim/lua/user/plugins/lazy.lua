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

-- -- Autocommand that reloads neovim whenever you save the plugins/init.lua file
-- vim.cmd [[
--     augroup packer_user_config
--         autocmd!
--         autocmd BufWritePost ~/.config/nvim/lua/user/plugins/init.lua source <afile> | PackerSync
--     augroup end
-- ]]

-- Install your plugins here
return require('lazy').setup({
    -- My plugins here

    -- Add new plugins here
    -- <gc> line comments, <gb> block comments
    {
        "numToStr/Comment.nvim",
        -- main = require('user.plugins.comment'),
    },

    -- Git wrapper for vim. Prefix :Git
    {
        "tpope/vim-fugitive",
        -- main = require('user.plugins.vim-fugitive'),
    },

    "tpope/vim-surround",        -- Surrounding pairs. cs"' ysiw] ysWfprint

    -- Telescope (plus Extentions)
    -- Notes: install ripgrep and fd for live-grep support
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        -- main = require('user.plugins.telescope'),
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        -- main = require('user.plugins.lsp'),
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "saadparwaiz1/cmp_luasnip" },  -- Snipper completion source
            { "hrsh7th/cmp-buffer" },        -- Buffer completion source
            { "hrsh7th/cmp-nvim-lsp" },      -- LSP completion source
        },
        -- main = require('user.plugins.nvim-cmp'),
    },          -- Completion engine
    -- Snippet engine (required for nvim-cmp)
    {
        "L3MON4D3/LuaSnip",
        -- main = require('user.plugins.luasnip'),
    },
    "rafamadriz/friendly-snippets",

    -- Formatting / Linting
    {
        "mhartington/formatter.nvim",
        -- main = require('user.plugins.formatter'),
    },
    {
        "mfussenegger/nvim-lint",
        -- main = require('user.plugins.nvim-lint'),
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() require('nvim-treesitter.install').update({
                with_sync = true
            }) end,
        -- main = require('user.plugins.treesitter'),
    },

    -- Colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        -- main = require('user.plugins.colorscheme'),
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        -- main = require('user.plugins.copilot'),
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua" },
        -- main = function ()
        --     require("copilot_cmp").setup()
        -- end
    },

})

