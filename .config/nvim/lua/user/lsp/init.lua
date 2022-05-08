local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

--
-- Customize UI
--
-- see vim.diagnostic.config

-- lsp setups
require("user.lsp.setups")
