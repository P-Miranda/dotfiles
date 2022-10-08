local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
    return
end


formatter.setup({
    filetype = {
        python = {
            -- Pick config from default
            require("formatter.filetypes.python").black,
        },
        c = {
            require("formatter.filetypes.c").clangformat,
        },
        cpp = {
            require("formatter.filetypes.c").clangformat,
        },
    }
})

-- Manual Format command
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>Format<cr>", opts)
