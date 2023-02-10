local lspconfig = require('lspconfig')
local lsp_util = require("lspconfig.util")

require('lspconfig.configs').eclair = {
  default_config = {
    cmd = { 'eclair', 'lsp' },
    filetypes = { 'eclair' },
    root_dir = lsp_util.find_git_ancestor,
    single_file_support = true,
  }
}

-- Set some less noisy defaults for diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, for errors only
    underline = { severity_limit = "Error" },
    -- Disable virtual text (too distracting)
    virtual_text = false,
    -- Enable signs
    signs = true,
    -- Show errors before warnings
    severity_sort = true,
  }
)

-- Jump directly to the first available definition, even if there's multiple results.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition."
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

-- LSP bindings:
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
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

-- Enable LSP servers
local servers = {
  sumneko_lua = { Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } } },
  clangd = {},
  rust_analyzer = {},
  hls = { haskell = { formattingProvider = "fourmolu" } },
  tsserver = {},
  eclair = {},
  -- gopls = {},
}

require('neodev').setup()
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end
}

-- nvim-cmp setup
local cmp = require 'cmp'
local compare = require('cmp').config.compare
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  -- TODO improve order...
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 4 },
    { name = 'path' },
    { name = 'luasnip' },
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.locality,
      compare.recently_used,
      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      compare.offset,
      compare.order
    }
  }
}

-- Treesitter setup:
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'lua', 'vim', 'help', 'c', 'cpp', 'go', 'python', 'rust',
    'typescript', 'javascript'
  },
  highlight = { enable = true, disable = {} },
  indent = { enable = false, disable = { 'python' } },
  context_commentstring = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- TODO treesitter folds

--   url = "~/.local/share/nvim/site/pack/packer/start/tree-sitter-souffle",
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.souffle = {
  install_info = {
    --  change this path to wherever you installed julienhenry/tree-sitter-souffle
    url = "~/.config/nvim/pack/plugins/start/tree-sitter-souffle",
    files = {"src/parser.c"}
  }
}

parser_config.eclair = {
  install_info = {
    url = "~/code/tree-sitter-eclair",
    files = {"src/parser.c"}
  }
}

-- Make error messages an easier to read color (same as in statusline):
vim.cmd [[highlight link LspDiagnosticsFloatingError GalaxyDiagnosticError]]
vim.cmd [[highlight link LspDiagnosticsSignError GalaxyDiagnosticError]]
