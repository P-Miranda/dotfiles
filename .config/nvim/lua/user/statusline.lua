-- -- Original Statusline
-- local stat_str = "%{FugitiveStatusline()}"      -- display git branch (vim-fugitive)
-- stat_str = stat_str .. "%f"                     -- relative filepath from current working directory
-- stat_str = stat_str .. "%m%r%w"                 -- modified, readonly, preview flags
-- stat_str = stat_str .. "%="                     -- align items to the right after this point
-- stat_str = stat_str .. "[%{&ff}]%y"             -- current filetype and syntax
-- stat_str = stat_str .. "[%p%%/%LL][%l,%c]"      -- lines %, total lines, current line and col
-- vim.opt.statusline = stat_str
-- vim.opt.laststatus = 2                          -- always show status bar

-- Statusline Lua Style
local stl = function(color)
    return table.concat({
        color('StatusLine'),
        color('Mode'),
        vim.api.nvim_get_mode().mode:upper(),
        color('Git'),
        "%{FugitiveStatusline()}",
        color('Filename'),
        "%f",
        "%m%r%w",
        "%=",
        color('Filetype'),
        "[%{&ff}]%y",
        color('LineCol'),
        "[%p%%/%LL][%l,%c]",
    },
    " "
    )
end

-- Set highlight group value
local function highlight_group(name)
    return '%#' .. name .. '#'
end

-- Choose between active and inactive/NC state
local function color_state(state, wrap)
    return function(name)
        if wrap == nil or wrap == true then
            return highlight_group(name .. state)
        end
        return name .. state
    end
end

-- Main StatusLine function
function StatusLine(type)
    if type == 'active' then
        return stl(color_state(''))
    end
    if type == 'inactive' then
        return stl(color_state('NC'))
    end
    return ''
end

-- Set highlight groups with [gruvbox color pallete](https://github.com/morhetz/gruvbox#dark-mode-1)
-- <group>NC is for the statusline of inactive buffer windows
local highlight_groups = {
    {'StatusLine'   , { colors = "guifg=#3c3836 guibg=#ebdbb2"          } },
    {'Mode'         , { colors = "guifg=#3c3836 guibg=#a89984 gui=bold" } },
    {'Git'          , { colors = "guifg=#ebdbb2 guibg=#665c54 gui=bold" } },
    {'Filename'     , { colors = "guifg=#a89984 guibg=#3c3836"          } },
    {'Filetype'     , { colors = "guifg=#ebdbb2 guibg=#665c54 gui=bold" } },
    {'LineCol'      , { colors = "guifg=#3c3836 guibg=#a89984 gui=bold" } },
    {'StatusLineNC' , { colors = "guifg=#3c3836 guibg=#a89984"          } },
    {'ModeNC'       , { colors = "guifg=#3c3836 guibg=#665c54 gui=bold" } },
    {'GitNC'        , { colors = "guifg=#a89984 guibg=#504945"          } },
    {'FilenameNC'   , { colors = "guifg=#a89984 guibg=#3c3836"          } },
    {'FiletypeNC'   , { colors = "guifg=#a89984 guibg=#504945"          } },
    {'LinecolNC'    , { colors = "guifg=#3c3836 guibg=#665c54"          } },
}

local get_hl_cmd = function(hl_group)
    return 'highlight ' .. hl_group[1] .. ' ' .. hl_group[2].colors
end

-- Create statuline autocmd group
local stl_augroup = vim.api.nvim_create_augroup("statusline", {clear = true})
-- Create statusline highlights
for _, hl_group in ipairs(highlight_groups) do
    vim.api.nvim_create_autocmd(
        {"ColorScheme"},
        {
            pattern = '*',
            command = get_hl_cmd(hl_group),
            group = stl_augroup
        }
    )
end
-- Set statusline active / inactive
vim.api.nvim_create_autocmd(
    {"WinEnter", "BufEnter"},
    {
        pattern = '*',
        command = "setlocal statusline=%!v:lua.StatusLine('active')",
        group = stl_augroup
    }
)
vim.api.nvim_create_autocmd(
    {"WinLeave", "BufLeave"},
    {
        pattern = '*',
        command = "setlocal statusline=%!v:lua.StatusLine('inactive')",
        group = stl_augroup
    }
)
