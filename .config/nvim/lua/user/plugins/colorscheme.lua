local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
    vim.cmd "colorscheme desert"
    return
end

vim.o.background = "dark"

-- set 80th column with specific color
vim.cmd [[
    highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
]]

gruvbox.setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
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

vim.cmd("colorscheme gruvbox")
