local options = {
    -- Misc
    backspace = { "indent", "eol", "start" },   -- expected backspace behaviour with indentation
    hidden = true,                              -- enable switching from non-saved buffers 
    lazyredraw = true,                          -- don't redraw while executing macros and non-typed commands
    clipboard = "unnamedplus",                  -- neovim can access system clipboard

    -- Appearance
    number = true,                              -- show line numbers
    relativenumber = false,                      -- show relative numbers from current line
    showcmd = true,                             -- Show partial command on bottom-right
    wrap = true,                                -- Wrap long text lines
    cursorline = true,                          -- highlight current line
    showmatch = true,                           -- highlight matching {[()]}
    scrolloff = 10,                             -- always show X lines above and below cursor line
    splitright = true,                          -- open new vertical splits on the right
    splitbelow = true,                          -- open new horizontal splits below
    textwidth = 0,                              -- do not wrap text after column 80 by default
    colorcolumn = "80",                         -- color column on 80th column
    breakindent = true,                         -- wrapped lines keep same indentation
    termguicolors = true,                       -- set term gui colors (most terminal support this) 

    -- Command Completion
    wildmenu = true,                            -- show vim command completion options
    wildmode = { "longest:full", "full" },      -- choose longest matching option first
    wildignorecase = true,                      -- ignore cases when matching commands

    -- Search
    hlsearch = false,                           -- no highlighting after search
    ignorecase = true,                          -- ignore case in search
    smartcase = true,                           -- don't ignore case with capitalized letter in search
    incsearch = true,                           -- show search results as you type

    -- Tabs and Spaces
    tabstop = 4,                                -- \t characters width measured in spaces
    shiftwidth = 4,                             -- identation width measured in spaces
    expandtab = true,                           -- expandtab: tabs are replaced by spaces*
    softtabstop = 4,                            -- tab or backspace keypress measured in spaces
    autoindent = true                           -- Copy indent from current line when starting a new one
    
}

--
-- Special identations
--
-- make: tabs can't be expanded to spaces
vim.cmd [[
    autocmd FileType make setlocal noexpandtab
]]

--
-- Filetype Syntax Highlighting
--
local filetype_augroup = vim.api.nvim_create_augroup("filetype_augroup", {clear = true})
vim.api.nvim_create_autocmd(
    {"BufRead,BufNewFile"},
    {
        pattern ={ '*.m' , '*.oct' },
        command = "set filetype=octave",
        group = filetype_augroup
    }
)
vim.api.nvim_create_autocmd(
    {"BufRead,BufNewFile"},
    {
        pattern ={ '*.vh', '*.sv' },
        command = "set filetype=verilog",
        group = filetype_augroup
    }
)

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Append to default configurations
-- Wildignore
vim.opt.wildignore:append({ "*.~", "*.swp", "*pyc"})
vim.opt.wildignore:append({ "*.o", "*.a", ".so" })
vim.opt.wildignore:append({ ".git/*" })

-- Highlight yanked region
-- [source](https://jdhao.github.io/2020/05/22/highlight_yank_region_nvim/#neovim-only)
local hl_yank_augroup = vim.api.nvim_create_augroup("highlight_yank", {clear = true})
vim.api.nvim_create_autocmd(
    {"TextYankPost"},
    {
        pattern = '*',
        command = "silent! lua vim.highlight.on_yank{higroup=\"IncSearch\", timeout=300}",
        group = hl_yank_augroup
    }
)

-- How info, hints, warnings and errors are displayed
vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = false,
    update_in_insert = true,
    severity_sort = false,
})
