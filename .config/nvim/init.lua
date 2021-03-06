-- Put main lua config files in runtime path
local lua_dir = os.getenv('HOME') .. '/.config/nvim/lua'
vim.o.rtp = lua_dir .. ',' .. vim.o.rtp

vim.g.mapleader = ' ' -- leader is space


require 'general_settings'
require 'keybindings'
require 'plugins'
require 'statusline'
require 'lsp'
require 'markdown'
require 'haskell'
require 'purescript'
require 'javascript'
require 'xml'

-- TODO fix clipboard on Linux
