-- Add $XDG_DATA_HOME/nvim/site to packpath (check vim.pack docs)
-- vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site/pack/*")
-- vim.opt.packpath:prepend(os.getenv("HOME") .. '/.local/share/nvim/site')
-- vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site/pack/*")
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")
--
-- No config plugins
--
vim.pack.add({
    "https://github.com/numToStr/Comment.nvim", -- <gc> line comments, <gb> block comments
    "https://github.com/mbbill/undotree"  -- Undo History :UndoTreeToggle
})
require("Comment").setup()

--
-- Lint
--
vim.pack.add({"https://github.com/mfussenegger/nvim-lint"})
local status_ok, lint = pcall(require, "lint")
lint.linters_by_ft = {
    python = {'ruff', 'mypy'},
    yaml = {'yamllint'},
}
-- Manual Lint command
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd> lua require('lint').try_lint()<cr>", opts)

--
-- Git
--
vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"}) -- :Gitsigns <command>
require("gitsigns").setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

--
-- Mini: Collection of various small independent plugins/modules
--
vim.pack.add({'https://github.com/echasnovski/mini.nvim'})
require('mini.ai').setup { n_lines = 500 } -- around/inside objects
require('mini.surround').setup()           -- Surround pairs. sd' sr)'

--
-- Colorscheme: Gruvbox
--
vim.pack.add({"https://github.com/ellisonleao/gruvbox.nvim"})

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
      strings = true,
      comments = true,
      operators = false,
      folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.o.background = "dark"
-- set 80th column with specific color
vim.cmd [[
    highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
]]
vim.cmd("colorscheme gruvbox")

--
-- Copilot TODO
--
-- vim.pack.add("https://github.com/zbirenbaum/copilot.lua")
-- TODO: check this: only run build if specific plugin was updated
-- vim.api.nvim_create_autocmd('PackChanged', {
-- 	callback = function(event)
-- 		if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
-- 			local ok = pcall(vim.cmd, 'TsUpdate')
-- 			if not ok then
-- 				vim.notify('TsUpdate failed!', vim.log.levels.WARN)
-- 			end
-- 		end
-- 	end,
-- })
