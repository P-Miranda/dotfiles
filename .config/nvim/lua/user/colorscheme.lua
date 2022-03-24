local colorscheme = "gruvbox"

-- set 80th column with specific color
vim.cmd [[
    highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
]]

vim.cmd [[
    autocmd vimenter * nested colorscheme gruvbox
    set background=dark
    let g:gruvbox_contrast_dark='medium'
]]

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.cmd "colorscheme desert"
    return
end
