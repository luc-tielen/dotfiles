local lspconfig = require('lspconfig')

-- lspconfig.hls.setup {
--   cmd = {'haskell-language-server-wrapper', '--lsp'},
--   settings = {
--     haskell = { formattingProvider = "fourmolu" },
--   },
-- }

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
local on_attach = function(client, bufnr)
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
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) TODO find non-conflicting keymap
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require('null-ls')
null_ls.setup({
  -- TODO: investigate why this doesn't work
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = lsp_format_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = lsp_format_augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(clients)
                return vim.tbl_filter(function(client)
                  if type(client) ~= "table" then
                    -- Not a table, just allow it for now.
                    -- Probably a bug in the corresponding LSP client?
                    return true
                  end

                  -- formatting needs to be disabled for some servers, for null-ls to do the formatting
                  local name = client.name
                  return name ~= 'tsserver' or name ~= 'clangd' or name ~= 'hls'
                end, clients)
              end
            })
          end
        })
    end
  end,
  sources = {
    --null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
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
  'stylelint_lsp',
  'svelte',
  'pylsp',
  'hls',
}
for _, lsp in ipairs(servers) do
  -- fix formatting race condition in hls
  lspconfig[lsp].setup { on_attach = on_attach }
end

local lsp_util = require("lspconfig.util")

lspconfig.rnix.setup {
  root_dir = lsp_util.root_pattern("flake.nix")
}

require'lspconfig'.kotlin_language_server.setup {
  root_dir = lsp_util.root_pattern("build.gradle.kts")
  --root_dir = lsp_util.root_pattern(".idea")
}

-- require 'lspconfig'.denols.setup { lint = true }

-- Make error messages an easier to read color (same as in statusline):
vim.cmd [[highlight link LspDiagnosticsFloatingError GalaxyDiagnosticError]]
vim.cmd [[highlight link LspDiagnosticsSignError GalaxyDiagnosticError]]
