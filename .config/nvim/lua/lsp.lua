local lspconfig = require('lspconfig')

lspconfig.hls.setup {
  cmd = {'haskell-language-server-wrapper', '--lsp'},
  settings = {
    haskell = { formattingProvider = "fourmolu" },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Disable virtual text (too distracting)
    virtual_text = false,
    -- Enable signs
    signs = true
  }
)

-- LSP bindings:
local on_attach = function(lsp_opts)
  return function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- LSP-powered autocompletion:
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- TODO check capabilities?
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)


    if lsp_opts.disable_formatting then
      client.resolved_capabilities.document_formatting = false
    end
    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    end
  end
end

local null_ls = require('null-ls')
null_ls.config({
  sources = {
    --null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.rustfmt,
  }
})

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches:
local servers = {'hls', 'tsserver', 'rust_analyzer', 'null-ls'}
for _, lsp in ipairs(servers) do
  -- tsserver formatting needs to be disabled, for null-ls to do the formatting
    -- fix formatting race condition in hls
  local lsp_opts = { disable_formatting = lsp == 'tsserver' or lsp == 'hls'}
  lspconfig[lsp].setup { on_attach = on_attach(lsp_opts) }
end

vim.cmd [[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})]]
vim.cmd [[autocmd CursorMoved <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})]]

-- Make error messages an easier to read color (same as in statusline):
vim.cmd [[highlight link LspDiagnosticsFloatingError GalaxyDiagnosticError]]
vim.cmd [[highlight link LspDiagnosticsSignError GalaxyDiagnosticError]]
