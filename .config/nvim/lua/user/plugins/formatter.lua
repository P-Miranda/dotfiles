local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
    return
end

local my_formatters = {}

-- temporary fix see: https://github.com/mhartington/formatter.nvim/issues/235
my_formatters.clangformat = function()
  local util = require("formatter.util")
  return {
    exe = "clang-format",
    args = {
      "-assume-filename",
      util.escape_path(util.get_current_buffer_file_name()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

formatter.setup({
    filetype = {
        python = {
            -- Pick config from default
            require("formatter.filetypes.python").black,
        },
        c = {
            -- require("formatter.filetypes.c").clangformat,
            my_formatters.clangformat,
        },
        cpp = {
            -- require("formatter.filetypes.c").clangformat,
            my_formatters.clangformat,
        },
    }
})

-- Manual Format command
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>Format<cr>", opts)
