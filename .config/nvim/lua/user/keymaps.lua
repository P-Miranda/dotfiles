local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- List and switch buffers
keymap("n", "<leader>b", ":ls<CR>:b<Space>*", opts)
-- Find file in subdirectories
keymap("n", "<leader>f", ":find<Space>*", opts)
-- External grep
keymap("n", "<leader>gr", ":gr<Space>-r<Space><Space>*<Left><Left>", opts)
-- Y behaves like D and C
keymap("n", "Y", "y$", opts)
-- Keep searches centered << centers cursor line
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)


-- Insert --
-- Press ii to exit insert mode
keymap("i", "ii", "<ESC>", opts)

-- Visual --
-- Press ii to exit insert mode
keymap("v", "ii", "<ESC>", opts)
-- Moving text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
-- Better tabs: gv re-selects text automatically
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Visual Block --

-- Terminal --

-- Command --
-- Press ii to exit command mode
keymap("c", "ii", "<esc>", opts)


-- Telescope Mappings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)    -- Find Files in $PWD
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)       -- Switch to other open buffers
keymap("n", "<leader>gr", "<cmd>Telescope live_grep<cr>", opts)     -- Grep for expression in $PWD
keymap("n", "<leader>fg", "<cmd>Telescope grep_string<cr>", opts)   -- Grep word under cursor
keymap("n", "<leader>tt", ":Telescope ", opts)                      -- Manual Telescope command
