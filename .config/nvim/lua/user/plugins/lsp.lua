local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

--
-- Customize UI
--
-- see vim.diagnostic.config

local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Info
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Movements
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)

  -- Code actions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

end

-- Add completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

--
-- luals
--
-- set the path to the lua_ls installation
-- Note: assumes lua_ls server is on $PATH
if 1 == vim.fn.executable "lua-language-server" then
    local lua_ls_binary = vim.fn.exepath('lua-language-server')
    local lua_ls_root_path = vim.fn.fnamemodify(lua_ls_binary, ':h:h')

    lspconfig.lua_ls.setup({
        cmd = {lua_ls_binary, "-E", lua_ls_root_path .. "/main.lua"};
        -- An example of settings for an LSP server.
        --    For more options, see nvim-lspconfig
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            }
        },
        capabilities = capabilities,
        on_attach = on_attach
    })
end

--
-- Clangd
--
if 1 == vim.fn.executable "clangd" then
    lspconfig.clangd.setup({
        cmd = {
            "clangd",
            "--clang-tidy"
        },
        capabilities = capabilities,
        on_attach = on_attach
    })
end
