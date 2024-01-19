local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = vim.fn.empty(vim.fn.glob(install_path)) > 0
if is_bootstrap then
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Plugins
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- Faster loading
  use 'lewis6991/impatient.nvim'
  -- Colorscheme:
  use 'atelierbram/Base2Tone-vim'
  -- use 'eemed/sitruuna.vim'
  -- Statusline:
  use 'glepnir/galaxyline.nvim'
  -- LSP:
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Additional neovim lua configuration, makes nvim development amazing
      'folke/neodev.nvim',
    }
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    }
  }
  -- Treesitter:
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    requires = {'julienhenry/tree-sitter-souffle', 'lyxell/nvim-treesitter-souffle'}
  }
  use 'nvim-treesitter/playground'
  -- Fuzzy finder:
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',  -- Update this as newer releases come out.
    requires = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim'}
  }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1
  }
  -- Project related plugins:
  use 'ahmedkhalf/project.nvim'
  -- Git related plugins:
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'rhysd/committia.vim'
  use 'rhysd/git-messenger.vim'
  -- Text manipulation:
  use 'tpope/vim-surround'
  use 'numToStr/Comment.nvim'
  use {'junegunn/goyo.vim', opt = true, cmd = {"Goyo", "Goyo!"}}
  use {'junegunn/limelight.vim', opt = true, cmd = {"Limelight"}}
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically:
  -- Icons:
  use 'kyazdani42/nvim-web-devicons'

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Normal start -> setup all plugins!

-- Project.nvim:
require("project_nvim").setup({
  detection_methods = { "pattern", "lsp" },
  patterns = { ".git", "_darcs", ".hg", ".bzr" },
})

-- Telescope:
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local telescope_previewers = require('telescope.previewers')
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close,
        ['<C-j>'] = telescope_actions.move_selection_next,
        ['<C-k>'] = telescope_actions.move_selection_previous,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      }
    },
    file_previewer = telescope_previewers.vim_buffer_cat.new,
    grep_previewer = telescope_previewers.vim_buffer_vimgrep.new,
    qflist_previewer = telescope_previewers.vim_buffer_qflist.new,
  }
}

local load_telescope_plugins = function()
  telescope.load_extension('ui-select')
  telescope.load_extension('projects')
  -- TODO telescope.load_extension('fzf')
  --telescope.load_extension('fzy_native')
end
if not pcall(load_telescope_plugins) then
  print "Failed to load Telescope plugins!"
end

-- Gitsigns:
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

-- Comment.nvim:
require('Comment').setup {
  toggler = { line = '<leader>/' },
  opleader = { line = '<leader>/' },
}
