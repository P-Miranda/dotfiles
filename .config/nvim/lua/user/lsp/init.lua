local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

--
-- Customize UI
--
-- How info, hints, warnings and errors are displayed
vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = false,
    update_in_insert = true,
    severity_sort = false,
})

-- lsp setups
require("user.lsp.setups")
