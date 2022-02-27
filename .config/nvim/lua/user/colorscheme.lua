local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.cmd "colorscheme desert"
    return
end

vim.cmd [[
    autocmd vimenter * nested colorscheme gruvbox
    set background=dark
]]
