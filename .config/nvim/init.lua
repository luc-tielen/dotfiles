-- Put main lua config files in runtime path
local lua_dir = os.getenv('HOME') .. '/.config/nvim/lua'
vim.o.rtp = lua_dir .. ',' .. vim.o.rtp

-- NOTE: must happen before plugins are required, or wrong leader will be used!
vim.g.mapleader = ' ' -- leader is space
vim.g.maplocalleader = ' ' -- leader is space

vim.g.have_nerd_font = true

require 'plugins'
require 'general_settings'
require 'keybindings'
require 'markdown'
require 'haskell'
require 'javascript'
require 'xml'

require 'globals'
