vim.cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq {'savq/paq-nvim', opt=true}

-- Fuzzy finder:
paq 'nvim-lua/plenary.nvim'
paq 'nvim-lua/popup.nvim'
paq 'nvim-telescope/telescope.nvim'
-- Statusline:
paq 'glepnir/galaxyline.nvim'
-- Colorscheme:
paq 'ayu-theme/ayu-vim'
-- Syntax highlighting:
paq 'sheerun/vim-polyglot'
paq 'norcalli/nvim-colorizer.lua'
paq {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
-- LSP:
paq 'neovim/nvim-lspconfig'
paq 'hrsh7th/nvim-compe'
-- TODO vsnip plugin?
-- Icons:
paq 'kyazdani42/nvim-web-devicons'
-- Git-related plugins:
paq 'tpope/vim-fugitive'
paq 'lewis6991/gitsigns.nvim'
paq 'rhysd/committia.vim'
paq 'rhysd/git-messenger.vim'
-- Focused editing:
paq 'junegunn/goyo.vim'
paq 'junegunn/limelight.vim'
-- Text manipulation:
paq 'tpope/vim-surround'
paq 'scrooloose/nerdcommenter'
-- Auto-formatting:
paq {'prettier/vim-prettier', run = 'yarn install'}
-- Set current dir to project root:
paq 'airblade/vim-rooter'
-- TODO plugin for better terminal integration?

-- Plugin configurations:

vim.g.rooter_silent_chdir = 1

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

local telescope_actions = require('telescope.actions')
local telescope_previewers = require('telescope.previewers')
require 'telescope'.setup {
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

require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
  indent = { enable = true },
}
-- TODO treesitter folds
-- TODO highlight TODOs (needs newer nvim-treesitter?)
