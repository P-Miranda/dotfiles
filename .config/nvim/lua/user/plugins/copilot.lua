-- Copilot.lua
local status_ok, copilot = pcall(require, "copilot")
if status_ok then
    copilot.setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
            python = true,
            c = true,
            cpp = true,
            verilog = true,
            make = true,
            bash = true,
            sh = true,
            lua = true,
            ["*"] = false, -- disable for all other filetypes by default
        }
    })
end
