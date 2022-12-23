-- Put main lua config files in runtime path
local lua_dir = os.getenv('HOME') .. '/.config/nvim/lua'
vim.o.rtp = lua_dir .. ',' .. vim.o.rtp

vim.g.mapleader = ' ' -- leader is space

if not pcall(function () require 'impatient' end) then
  print('Impatient failed to load!')
end

require 'general_settings'
require 'keybindings'
require 'plugins'
require 'statusline'
require 'lsp'
require 'markdown'
require 'haskell'
require 'javascript'
require 'xml'


require 'globals'
