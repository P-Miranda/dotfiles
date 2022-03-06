local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

-- Global Telescope Customizations
telescope.setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    -- Default configuration for telescope goes here:
    -- check lua/telescope/mappings.lua for default mappings
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      },
      
      n = {
      },
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
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
