-- Small setups for lua plugins

-- Comment.nvim
local status_ok, comment = pcall(require, "Comment")
if status_ok then
    comment.setup()

    -- Unsupported filetypes
    -- local ft = comment.ft
    -- ft.set("filetype", {'linecmnt', 'blckcmnt'})
    -- ft.set("octave", {'#%s', '#{\n%s}#'})
end


-- vim-fugitive
-- delete fugitive buffers automatically
vim.cmd [[
    autocmd BufReadPost fugitive://* set bufhidden=delete
]]
