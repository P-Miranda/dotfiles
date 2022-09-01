local status_ok, lint = pcall(require, "lint")
if not status_ok then
    return
end

lint.linters_by_ft = {
    python = {'flake8',},
}

-- Manual Lint command
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>lt", "lua require('lint').try_lint()", opts)

-- Lint after save asynchronously
-- local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", {clear = true})
-- vim.api.nvim_create_autocmd(
--     {"BufWritePost"},
--     {
--         -- pattern = '*',
--         pattern = {"*.py"},
--         command = "lua require('lint').try_lint()",
--         group = lint_augroup
--     }
-- )
