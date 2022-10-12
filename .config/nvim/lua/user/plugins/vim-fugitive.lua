-- delete fugitive buffers automatically
vim.cmd [[
    autocmd BufReadPost fugitive://* set bufhidden=delete
]]
