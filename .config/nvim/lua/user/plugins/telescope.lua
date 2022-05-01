local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

-- Global Telescope Customizations
telescope.setup{
  -- Default configuration for telescope goes here:
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
    },
    file_ignore_patterns = {
        '.git/*',
        '.cache/clangd/*',
    },
    sorting_strategy = 'ascending',
    -- check lua/telescope/mappings.lua for default mappings
    mappings = {
      i = {
      },
      n = {
      },
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    find_files = {
        hidden = true,
        no_ignore = true,
        previewer = false,
        layout_config = {
            width = 80,
        },
    },
    grep_string = {
        path_display = {
            "shorten",
        },
        hidden = true,
        no_ignore = true,
    },
    live_grep = {
        path_display = {
            "shorten",
        },
        hidden = true,
        no_ignore = true,
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
    }
  }
}

-- load telescope extentions
telescope.load_extension('fzf')

-- Custom telescope pickers
local my_telescope = {}

-- Find file in nvim config
my_telescope.find_nvim_config = function()
    require('telescope.builtin').find_files({
        cwd = '~/.config/nvim',
        prompt_title = '~ nvim config ~',
    })
end

return my_telescope
