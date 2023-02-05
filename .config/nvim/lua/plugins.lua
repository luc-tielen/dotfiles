vim.cmd 'packadd packer.nvim'

local packer = require('packer')
packer.startup(function()
  use 'wbthomason/packer.nvim'

  -- Faster loading
  use 'lewis6991/impatient.nvim'

  -- Fuzzy finder:
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  -- Statusline:
  use 'glepnir/galaxyline.nvim'
  -- Colorscheme:
  use 'atelierbram/Base2Tone-vim'
  --use 'ayu-theme/ayu-vim'
  --use 'shaunsingh/nord.nvim'
  --use 'zefei/simple-dark'
  --use 'rainglow/vim'
  -- Syntax highlighting:
  use 'sheerun/vim-polyglot'
  use 'norcalli/nvim-colorizer.lua'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'
  use 'julienhenry/tree-sitter-souffle'
  use 'lyxell/nvim-treesitter-souffle'
  -- LSP:
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'jose-elias-alvarez/null-ls.nvim'
  -- Text manipulation:
  use 'tpope/vim-surround'
  use 'numToStr/Comment.nvim'
  -- Git-related plugins:
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'rhysd/committia.vim'
  use 'rhysd/git-messenger.vim'
  -- Always set current dir to project root:
  use "ahmedkhalf/project.nvim"
  -- Focused editing:
  use {'junegunn/goyo.vim', opt = true, cmd = {"Goyo", "Goyo!"}}
  use {'junegunn/limelight.vim', opt = true, cmd = {"Limelight"}}
  -- Icons:
  use 'kyazdani42/nvim-web-devicons'
end)

-- Plugin configurations:
require("project_nvim").setup({
  detection_methods = { "pattern", "lsp" },
  patterns = { ".git", "_darcs", ".hg", ".bzr" },
})
require('Comment').setup()

require('compe').setup {
  min_length = 2,
  source = {
    path     = true,
    buffer   = true,
    nvim_lsp = true,
    nvim_lua = true,
    nvim_treesitter = true
  }
}

local gutter_symbol = '|'
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitGutterAdd'   , text = gutter_symbol},
    change       = {hl = 'GitGutterChange', text = gutter_symbol},
    delete       = {hl = 'GitGutterDelete', text = gutter_symbol},
    topdelete    = {hl = 'GitGutterDelete', text = gutter_symbol},
    changedelete = {hl = 'GitGutterChange', text = gutter_symbol},
  }
}

local telescope = require 'telescope'
local telescope_actions = require('telescope.actions')
local telescope_previewers = require('telescope.previewers')
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close,
        ['<C-j>'] = telescope_actions.move_selection_next,
        ['<C-k>'] = telescope_actions.move_selection_previous
      }
    },
    file_previewer = telescope_previewers.vim_buffer_cat.new,
    grep_previewer = telescope_previewers.vim_buffer_vimgrep.new,
    qflist_previewer = telescope_previewers.vim_buffer_qflist.new,
  }
}
telescope.load_extension('ui-select')
require('telescope').load_extension('projects')
--telescope.load_extension('fzy_native')

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = 'maintained',
  highlight = { enable = true, disable = {} },  -- TODO: fix issues
  indent = { enable = false },
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
