-- Small setups for lua plugins

-- Comment.nvim
require('Comment').setup()
-- Unsupported filetypes
local ft = require('Comment.ft')
-- ft.set("filetype", {'linecmnt', 'blckcmnt'})
-- ft.set("octave", {'#%s', '#{\n%s}#'})


-- vim-fugitive
-- delete fugitive buffers automatically
vim.cmd [[
    autocmd BufReadPost fugitive://* set bufhidden=delete
]]
