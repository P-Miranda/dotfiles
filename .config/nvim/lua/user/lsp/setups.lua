local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

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
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

--
-- sumneko lua
--
-- set the path to the sumneko installation
-- Note: assumes sumneko server is on $PATH
if 1 == vim.fn.executable "lua-language-server" then
    local sumneko_binary = vim.fn.exepath('lua-language-server')
    local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary, ':h:h')

    lspconfig.sumneko_lua.setup({
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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
else
    -- print("lua-language-server not in $PATH")
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
else
    -- print("clangd not in $PATH")
end

