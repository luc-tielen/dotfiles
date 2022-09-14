vim.cmd 'packadd packer.nvim'

local packer = require('packer')
packer.startup(function()
  use 'wbthomason/packer.nvim'

  -- Fuzzy finder:
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  --use 'luc-tielen/telescope_hoogle'
  -- Statusline:
  use 'glepnir/galaxyline.nvim'
  -- Colorscheme:
  --use 'ayu-theme/ayu-vim'
  use 'atelierbram/Base2Tone-vim'
  --use 'shaunsingh/nord.nvim'
  --use 'zefei/simple-dark'
  --use 'rainglow/vim'
  -- Syntax highlighting:
  use 'sheerun/vim-polyglot'
  use 'norcalli/nvim-colorizer.lua'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat'}
  use 'nvim-treesitter/playground'
  use 'julienhenry/tree-sitter-souffle'
  use 'lyxell/nvim-treesitter-souffle'
  -- LSP:
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'jose-elias-alvarez/null-ls.nvim'
  -- TODO vsnip plugin?
  -- Commenting:
  use 'numToStr/Comment.nvim'
  -- Icons:
  use 'kyazdani42/nvim-web-devicons'
  -- Git-related plugins:
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'rhysd/committia.vim'
  use 'rhysd/git-messenger.vim'
  -- Focused editing:
  use {'junegunn/goyo.vim', opt = true, cmd = {"Goyo", "Goyo!"}}
  use {'junegunn/limelight.vim', opt = true, cmd = {"Limelight"}}
  -- Text manipulation:
  use 'tpope/vim-surround'
  use 'b3nj5m1n/kommentary'
  -- Auto-formatting:
  -- Set current dir to project root:
  use 'airblade/vim-rooter'
  -- TODO plugin for better terminal integration?
end)

-- Plugin configurations:

vim.g.rooter_silent_chdir = 1
vim.g.kommentary_create_default_mappings = false

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

local gutter = '|'
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitGutterAdd'   , text = gutter},
    change       = {hl = 'GitGutterChange', text = gutter},
    delete       = {hl = 'GitGutterDelete', text = gutter},
    topdelete    = {hl = 'GitGutterDelete', text = gutter},
    changedelete = {hl = 'GitGutterChange', text = gutter},
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
--telescope.load_extension('fzy_native')
--telescope.load_extension('hoogle')

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
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    }
  }
}
-- TODO treesitter folds
-- TODO highlight TODOs (needs newer nvim-treesitter?)


local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.souffle = {
  install_info = {
    url = "~/.local/share/nvim/site/pack/packer/start/tree-sitter-souffle",
    files = {"src/parser.c"}
  }
}
parser_config.eclair = {
  install_info = {
    url = "~/personal/tree-sitter-eclair",
    files = {"src/parser.c"}
  }
}

