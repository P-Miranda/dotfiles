local status_ok, lint = pcall(require, "lint")
if not status_ok then
    return
end

lint.linters_by_ft = {
    python = {'flake8',},
}

-- Lint after save asynchronously
local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", {clear = true})
vim.api.nvim_create_autocmd(
    {"BufWritePost"},
    {
        -- pattern = '*',
        pattern = {"*.py"},
        command = "lua require('lint').try_lint()",
        group = lint_augroup
    }
)
