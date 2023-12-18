local status_ok, lint = pcall(require, "lint")
if not status_ok then
    return
end

local flake8 = lint.linters.flake8
flake8.args = {
    '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
    '--no-show-source',
    '--max-line-length=88',
    '-',
}

lint.linters_by_ft = {
    python = {'flake8'},
    yaml = {'yamllint'},
}

-- Manual Lint command
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>lua require('lint').try_lint()<CR>", opts)
