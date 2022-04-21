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
null_ls.setup({
  sources = {
    --null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.clang_format,
  }
})

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches:
local servers = {
  'zls',
  'rust_analyzer',
  'clangd',
  'tsserver',
  'svelte',
  'pylsp',
  'hls',
}
for _, lsp in ipairs(servers) do
  -- tsserver formatting needs to be disabled, for null-ls to do the formatting
  -- fix formatting race condition in hls
  local lsp_opts = { disable_formatting = lsp == 'tsserver' or lsp == 'clangd' or lsp == 'hls' }
  lspconfig[lsp].setup { on_attach = on_attach(lsp_opts) }
end

local lsp_util = require("lspconfig.util")

lspconfig.rnix.setup {
  root_dir = lsp_util.root_pattern("flake.nix")
}

require'lspconfig'.kotlin_language_server.setup {
  root_dir = lsp_util.root_pattern("build.gradle.kts")
  --root_dir = lsp_util.root_pattern(".idea")
}

-- lspconfig.hls.setup {
--   cmd = {'haskell-language-server', '--lsp'},
--   on_attach = on_attach({disable_formatting = true})
-- }

-- Make error messages an easier to read color (same as in statusline):
vim.cmd [[highlight link LspDiagnosticsFloatingError GalaxyDiagnosticError]]
vim.cmd [[highlight link LspDiagnosticsSignError GalaxyDiagnosticError]]
