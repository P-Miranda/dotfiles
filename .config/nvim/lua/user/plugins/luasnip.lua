local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    return
end

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

-- keymaps
-- expand or jump to next completion
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- jump to previous completion
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- select choice nodes
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)



