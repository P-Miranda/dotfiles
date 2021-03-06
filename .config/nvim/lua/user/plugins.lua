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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
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

-- Plugin Configurations
require("user.plugins.nvim-cmp")
require("user.plugins.telescope")
require("user.plugins.formatter")
require("user.plugins.nvim-lint")
require("user.plugins.others")

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"    -- Have packer manage itself

    -- Add new plugins here
    use "numToStr/Comment.nvim"     -- <gc> line comments, <gb> block comments
    use "tpope/vim-fugitive"        -- Git wrapper for vim. Prefix :Git
    use "tpope/vim-surround"        -- Surrounding pairs. cs"' ysiw] ysWfprint
    use "morhetz/gruvbox"           -- Colorscheme

    -- Telescope (plus Extentions)
    -- Notes: install ripgrep for live-grep support
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- LSP
    use "neovim/nvim-lspconfig"     -- Collection of configurations for the built-in LSP client

    -- Completion
    use "hrsh7th/nvim-cmp"          -- Completion engine
    use "L3MON4D3/LuaSnip"          -- Snippet engine (required for nvim-cmp)
    use "saadparwaiz1/cmp_luasnip"  -- Snipper completion source
    use "hrsh7th/cmp-buffer"        -- Buffer completion source
    use "hrsh7th/cmp-nvim-lsp"      -- LSP completion source

    -- Formatting / Linting
    use "mhartington/formatter.nvim"-- Format runner
    use "mfussenegger/nvim-lint"    -- Async Linter (uses vim.diagnostic)

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

