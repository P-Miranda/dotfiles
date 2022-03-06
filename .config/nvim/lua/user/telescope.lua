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
