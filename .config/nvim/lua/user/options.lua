local options = {
    -- Misc
    backspace = { "indent", "eol", "start" },   -- expected backspace behaviour with indentation
    hidden = true,                              -- enable switching from non-saved buffers 
    lazyredraw = true,                          -- don't redraw while executing macros and non-typed commands
    clipboard = "unnamedplus",                  -- neovim can access system clipboard

    -- Appearance
    number = true,                              -- show line numbers
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
vim.cmd [[
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave
    au! BufRead,BufNewFile *.vh,*.sv set filetype=verilog
]]
-- set 80th column with specific color
vim.cmd [[
    highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
]]

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Append to default configurations
-- Wildignore
vim.opt.wildignore:append( { "*.~", "*.swp", "*pyc"})
vim.opt.wildignore:append( { "*.o", "*.a", ".so" })
vim.opt.wildignore:append( { ".git/*" })
-- Path
vim.opt.path:append( { "**" } )                 -- find files in all subdirectories from $PWD

-- Statusline
local stat_str = "%{FugitiveStatusline()}"                           -- display git branch (vim-fugitive)
stat_str = stat_str .. "%f"                     -- relative filepath from current working directory
stat_str = stat_str .. "%m%r%w"                 -- modified, readonly, preview flags
stat_str = stat_str .. "%="                     -- align items to the right after this point
stat_str = stat_str .. "[%{&ff}]%y"             -- current filetype and syntax
stat_str = stat_str .. "[%p%%/%LL][%l,%c]"      -- lines %, total lines, current line and col
vim.opt.statusline = stat_str
vim.opt.laststatus = 2                          -- always show status bar

-- vim-fugitive
-- delete fugitive buffers automatically
vim.cmd [[
    autocmd BufReadPost fugitive://* set bufhidden=delete
]]
