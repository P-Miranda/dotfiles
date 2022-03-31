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
-- Y behaves like D and C
keymap("n", "Y", "y$", opts)
-- Keep searches centered << centers cursor line
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
-- Quickfix list navegation
keymap("n", "<C-j>", "<cmd>cnext<cr>", opts)
keymap("n", "<C-k>", "<cmd>cprevious<cr>", opts)
-- Change local buffer working directory to my notes
keymap("n", "<leader>md", "<cmd>lcd ~/mdnotes<cr>", opts)


-- Insert --
-- Press ii to exit insert mode
keymap("i", "ii", "<esc>", opts)

-- Visual --
-- Press ii to exit insert mode
keymap("v", "ii", "<esc>", opts)
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
-- Find Files in $PWD
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)    
-- Switch to other open buffers
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)      
-- Grep for expression in $PWD
keymap("n", "<leader>gr", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)     
-- Grep word under cursor
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)   
-- Manual Telescope command
keymap("n", "<leader>tt", ":Telescope ", opts)                      
-- Find file in nvim config
keymap("n", "<leader>frc", "<cmd>lua require('user.plugins.telescope').find_nvim_config()<cr>", opts) 

-- Fugitive Mappings
-- Open 3-way split for merge conflicts
keymap("n", "<leader>gds", "<cmd>Gvdiffsplit!<cr>", opts) 
-- Choose HEAD/local/left diff
keymap("n", "<leader>gdh", "<cmd>diffget //2<cr>", opts) 
-- Choose incomming/right diff
keymap("n", "<leader>gdl", "<cmd>diffget //3<cr>", opts) 
