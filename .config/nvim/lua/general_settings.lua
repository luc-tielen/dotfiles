local u = require 'utils'

local o = vim.o
local wo = vim.wo
local bo = vim.bo

vim.cmd 'syntax on'
vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax sync minlines=256'    -- Highlight 256 lines at a time

o.compatible = false    -- Vim, not Vi!
o.encoding = 'UTF-8'    -- Use utf8-encoding
o.title = true          -- File name in terminal title
o.hidden = true         -- Hide buffers instead of closing them
o.history = 1000        -- Remember last 1000 commands
o.timeoutlen = 200      -- Shorter timeout when typing commands in normal mode
o.shortmess = 'aotIcF'  -- Don't show startup-message, shorten most info messages
o.autoread = true       -- Reload files when changed outside of vim
o.backup = false        -- Don't create backup files
o.swapfile = false      -- Don't use a swap file
o.visualbell = false    -- No visual bell (flashing screen)
o.errorbells = false    -- No audible bell (beeps)
o.laststatus = 3        -- Always show statusbar, globally

o.hlsearch = true     -- Highlight during search
o.ignorecase = true   -- Ignore case when searching
o.smartcase = true    -- Don't ignore case if search contains capital letters
o.incsearch = true    -- Instantly show search results
o.gdefault = true     -- Globally substitute by default

o.splitbelow = true  -- Opens new vertical windows below
o.splitright = true  -- Opens new horizontal windows right

o.clipboard = 'unnamedplus'  -- Use system clipboard

o.bs = 'indent,eol,start'  -- Normal backspace

wo.relativenumber = true
wo.number = true
wo.numberwidth = 1
o.showmatch = true       -- Highlight matching {}, {}, ...
wo.cursorline = false    -- Don't show cursorline (for speed..)
wo.cursorcolumn = false  -- Don't show cursor column (for speed..)
wo.signcolumn = 'yes'    -- Always shown signcolumn
wo.wrap = false          -- Don't wrap lines.

o.lazyredraw = true  -- Only redraw new graphics (terminal only)

o.paste = false   -- Auto-format when pasting
o.foldlevel = 99  -- Start everything unfolded by default

-- Standard => tab = 2 spaces:
o.autoindent = true -- Copy indent previous line to next line
o.tabstop = 2       -- Tab = 2 chars long
o.shiftwidth = 2    -- Number of spaces to use for autoindent
o.softtabstop = 2   -- <BS> removes tabs (even if tab = spaces)
o.expandtab = true  -- Change tabs to spaces
bo.expandtab = true  -- Change tabs to spaces

o.inccommand = "nosplit"  -- Show substitution on the fly, in same window
o.virtualedit = ""        -- Only allow cursor where characters are
o.wildmenu = true         -- Better command-line completion (when using ':')
o.wildmode = "full"       -- Complete next match when tab is used (during ':')

bo.synmaxcol = 200  -- Highlight only first 200 characters of a line
o.updatetime = 500
o.scrolloff = 8     --  Start scrolling 8 lines before edge of viewport

o.shiftround = true  -- Always indent by multiple of shift width

-- File type recognition:
u.au 'BufNewFile,BufRead *.jison set filetype=yacc'
vim.cmd [[au BufNewFile,BufRead *.eclair set filetype=eclair]]
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
wo.cursorline = true
vim.cmd 'hi clear CursorLine'
vim.cmd 'hi CursorLineNr guifg=#DDDD00'
vim.cmd 'hi LineNr guifg=#888888'
vim.cmd 'hi SignColumn guibg=#0F1419'

-- Looks for matches in all buffer/windows and tags
vim.cmd 'set complete=.,w,b,u,t,k'

-- Show multiple completions, manually select an item.
o.completeopt = 'menuone,noselect'

-- Enable mouse support:
if vim.fn.has('mouse') == 1 then
  o.mouse = 'a'
end
