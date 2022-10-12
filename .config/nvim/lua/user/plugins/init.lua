local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins/init.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost ~/.config/nvim/lua/user/plugins/init.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
    open_fn = function()
          return require("packer.util").float { border = "rounded" }
    end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"    -- Have packer manage itself

    -- Add new plugins here
    -- <gc> line comments, <gb> block comments
    use {
        "numToStr/Comment.nvim",
        config = "require('user.plugins.comment')",
    }

    -- Git wrapper for vim. Prefix :Git
    use {
        "tpope/vim-fugitive",
        config = "require('user.plugins.vim-fugitive')",
    }

    use "tpope/vim-surround"        -- Surrounding pairs. cs"' ysiw] ysWfprint

    -- Telescope (plus Extentions)
    -- Notes: install ripgrep and fd for live-grep support
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        config = "require('user.plugins.telescope')",
    }

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        config = "require('user.plugins.lsp')",
    }

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "saadparwaiz1/cmp_luasnip" },  -- Snipper completion source
            { "hrsh7th/cmp-buffer" },        -- Buffer completion source
            { "hrsh7th/cmp-nvim-lsp" },      -- LSP completion source
        },
        config = "require('user.plugins.nvim-cmp')",
    }          -- Completion engine
    use "L3MON4D3/LuaSnip"          -- Snippet engine (required for nvim-cmp)

    -- Formatting / Linting
    use {
        "mhartington/formatter.nvim",
        config = "require('user.plugins.formatter')",
    }
    use {
        "mfussenegger/nvim-lint",
        config = "require('user.plugins.nvim-lint')",
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({
                with_sync = true
            }) end,
        config = "require('user.plugins.treesitter')",
    }

    -- Colorscheme
    use {
        "ellisonleao/gruvbox.nvim",
        config = "require('user.plugins.colorscheme')",
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

