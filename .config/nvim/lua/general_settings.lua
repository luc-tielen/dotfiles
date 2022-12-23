local u = require 'utils'

local opt = vim.opt
local o = vim.o

vim.cmd 'syntax on'
vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax sync minlines=256'    -- Highlight 256 lines at a time

-- Vim, not Vi!
opt.compatible = false
-- Don't show the mode, already shown using plugin anyway.
opt.showmode = false
-- Use utf8-encoding
opt.encoding = 'UTF-8'
-- File name in terminal title
opt.title = true
-- Hide buffers instead of closing them
opt.hidden = true
-- Remember last 1000 commands
opt.history = 1000
-- Shorter timeout when typing commands in normal mode
opt.timeoutlen = 200
-- Don't show startup-message, shorten most info messages
opt.shortmess:append('aotIcF')
o.autoread = true       -- Reload files when changed outside of vim
-- Don't create backup files
opt.backup = false
-- Don't use a swap file
opt.swapfile = false
o.visualbell = false    -- No visual bell (flashing screen)
o.errorbells = false    -- No audible bell (beeps)
-- Always show statusbar, globally
opt.laststatus = 3

-- Highlight during search
opt.hlsearch = true
-- Ignore case when searching
opt.ignorecase = true
-- Don't ignore case if search contains capital letters
opt.smartcase = true
-- Instantly show search results
opt.incsearch = true
o.gdefault = true     -- Globally substitute by default

-- Opens new vertical windows below
opt.splitbelow = true
-- Opens new horizontal windows right
opt.splitright = true

-- Use system clipboard
opt.clipboard = 'unnamedplus'

o.bs = 'indent,eol,start'  -- Normal backspace

-- Persistent undo
opt.undofile = true

-- Better diffing
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- Hybrid line numbers
opt.relativenumber = true
opt.number = true
opt.numberwidth = 1
-- Highlight matching {}, {}, ...
opt.showmatch = true
opt.cursorcolumn = false  -- Don't show cursor column (for speed..)
-- Always shown signcolumn
opt.signcolumn = "yes"
-- Don't wrap lines.
opt.wrap = false

o.lazyredraw = true  -- Only redraw new graphics (terminal only)

o.paste = false   -- Auto-format when pasting

opt.foldmethod = "marker"
-- Start everything unfolded by default
opt.foldlevel = 99

-- Standard => tab = 2 spaces:
-- Copy indent previous line to next line
opt.autoindent = true
-- Tab = 2 chars long
opt.tabstop = 2
-- Number of spaces to use for autoindent
opt.shiftwidth = 2
-- <BS> removes tabs (even if tab = spaces)
opt.softtabstop = 2
-- Change tabs to spaces
opt.expandtab = true

-- Show substitution on the fly, in same window
opt.inccommand = "nosplit"
o.virtualedit = ""        -- Only allow cursor where characters are
o.wildmenu = true         -- Better command-line completion (when using ':')
o.wildmode = "full"       -- Complete next match when tab is used (during ':')

-- Highlight only first 200 characters of a line
opt.synmaxcol = 200
-- Make updates happen faster
opt.updatetime = 500
-- Start scrolling 8 lines before edge of viewport
opt.scrolloff = 8

o.shiftround = true  -- Always indent by multiple of shift width

opt.equalalways = false  -- Less changing of window sizes

-- shada = shared data files
-- ! = save and restore global vars
-- '1000 = remember max 1000 marked files
-- <50 = remember 50 lines per register
-- s10 = files can be max 10kB
opt.shada = { "!", "'1000", "<50", "s10", "h" }

-- File type recognition:
u.au 'BufNewFile,BufRead *.jison set filetype=yacc'
vim.cmd [[au BufNewFile,BufRead *.eclair set filetype=eclair]]
vim.cmd [[au BufNewFile,BufRead *.dbscheme set filetype=yaml]]
vim.cmd [[au BufNewFile,BufRead *.ll set filetype=llvm]]
vim.cmd [[au BufNewFile,BufRead *.dl set filetype=souffle]]
vim.cmd [[au BufNewFile,BufRead *.gdb set filetype=gdb]]

-- Indentation specific for certain files:
u.create_augroup('fmt', {
  {'FileType', 'mkd', 'set', 'ts=4', 'sw=4', 'sts=4', 'noet'},  -- Makefile: tab = 4 wide (no spaces)
  -- Python, C, C++, Elm, css, scss: tab = 4 spaces
  {'FileType', 'python', 'set', 'ts=4', 'sw=4', 'sts=4'},
  {'FileType', 'c', 'set', 'ts=4', 'sw=4', 'sts=4'},
  {'FileType', 'cpp', 'set', 'ts=4', 'sw=4', 'sts=4'},
  {'FileType', 'elm', 'set', 'ts=4', 'sw=4', 'sts=4'},
  {'FileType', 'css', 'set', 'ts=4', 'sw=4', 'sts=4'},
  {'FileType', 'scss', 'set', 'ts=4', 'sw=4', 'sts=4'},

  {'BufRead,BufNewFile', '*.md', 'setlocal', 'textwidth=80'},  -- max 80 chars for markdown files
  {'BufRead,BufNewFile', '*.wsdl', 'set', 'filetype=xml'},     -- Treat WSDL as XML
  {'FileType', '*', 'setlocal', 'formatoptions-=cro'}          -- Don't add comments on next line automatically
})

strip_trailing_whitespace = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd '%s/\\s\\+$//e'
  vim.api.nvim_win_set_cursor(0, pos)
end

u.create_augroup('opening', {
  -- Center buffer around cursor when opening files:
  {'BufRead', '*', 'normal', 'zz'},
  -- Deletes trailing whitespace before writing a buffer:
  {'BufWritePre', '*', 'lua strip_trailing_whitespace()'},
  -- Changes working directory to that of currently used buffer:
  {'BufEnter', '*', 'silent!', 'lcd', '%:p:h'},
})

-- Remember cursor position between vim sessions
vim.cmd [[autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- Colorscheme
o.termguicolors = true
--vim.cmd 'let ayucolor="dark"'
--vim.cmd 'colorscheme ayu'
--vim.cmd 'colorscheme simple-dark'
--vim.cmd 'colorscheme stasis'
o.background = 'dark'  -- Dark background
--require('nord').set()
vim.cmd 'colorscheme Base2Tone_EveningDark'
vim.cmd "highlight WinSeparator guibg=None"  -- Better window separators combined with global statusline

-- Enable nvim-colorizer plugin
require('colorizer').setup()

-- Highlighting of current line number
opt.cursorline = true
vim.cmd 'hi clear CursorLine'
vim.cmd 'hi CursorLineNr guifg=#DDDD00'
vim.cmd 'hi LineNr guifg=#888888'
vim.cmd 'hi SignColumn guibg=#0F1419'

-- Looks for matches in all buffer/windows and tags
vim.cmd 'set complete=.,w,b,u,t,k'

-- Show multiple completions, manually select an item.
opt.completeopt = {'menuone', 'noselect'}

-- Enable mouse support:
if vim.fn.has('mouse') == 1 then
  opt.mouse = 'a'
end
