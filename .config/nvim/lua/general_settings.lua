local u = require 'utils'

local opt = vim.opt

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
opt.autoread = true       -- Reload files when changed outside of vim
-- Don't create backup files
opt.backup = false
-- Don't use a swap file
opt.swapfile = false
-- No visual bell (flashing screen)
opt.visualbell = false
-- No audible bell (beeps)
opt.errorbells = false
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
-- Globally substitute by default
opt.gdefault = true

-- Opens new vertical windows below
opt.splitbelow = true
-- Opens new horizontal windows right
opt.splitright = true

-- Use system clipboard
opt.clipboard = 'unnamedplus'

-- Normal backspace
opt.backspace = 'indent,eol,start'

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
-- Don't show cursor column (for speed..)
opt.cursorcolumn = false
-- Always shown signcolumn
opt.signcolumn = "yes"
-- Don't wrap lines.
opt.wrap = false
-- For the rare occassion wrap *is* turned on, visually indent the wrapped lines.
opt.breakindent = true

-- Only redraw new graphics (terminal only)
-- opt.lazyredraw = true

-- Auto-format when pasting
opt.paste = false

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
-- Only allow cursor where characters are
opt.virtualedit = ""
-- Better command-line completion (when using ':')
opt.wildmenu = true
-- Complete next match when tab is used (during ':')
-- If multiple solutions are possible, it will only complete the common part.
opt.wildmode = "full"
-- Only show matches in a popup menu
opt.wildoptions = "pum"
-- Ignore compiled files
opt.wildignore = "Cargo.lock"
opt.wildignore:append { "*.o", "*.a", "*.so", "*~" }

-- Highlight only first 200 characters of a line
opt.synmaxcol = 200
-- Make updates happen faster
opt.updatetime = 500
-- Start scrolling 8 lines before edge of viewport
opt.scrolloff = 8

-- Always indent by multiple of shift width
opt.shiftround = true

-- Less changing of window sizes
opt.equalalways = false

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
vim.cmd [[au BufNewFile,BufRead *.qjs set filetype=javascript]]
vim.cmd [[au BufNewFile,BufRead *.mdx set filetype=markdown]]

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
  {'FileType', 'astro', 'set', 'ts=2', 'sw=2', 'sts=2'},

  {'BufRead,BufNewFile', '*.md', 'setlocal', 'textwidth=80'},  -- max 80 chars for markdown files
  {'BufRead,BufNewFile', '*.wsdl', 'set', 'filetype=xml'},     -- Treat WSDL as XML
  {'BufRead,BufNewFile', '*.tfvars', 'set', 'filetype=terraform'}, -- Also use terraform syntax for .tfvars
})
-- TODO fix formatoptions: reset after each new buffer
opt.formatoptions = opt.formatoptions
  + "q" -- Allow formatting comments w/ gq
  + "j" -- Auto-remove comments if possible.
  + "n" -- Auto-indent text in numbered lists.
  - "a" -- Don't autoformat paragraphs
  - "t" -- Don't auto wrap text (code)
  - "c" -- Dont'add comments on next line automatically.
  - "r" -- Don't continue comments when pressing enter.
  - "o" -- O and o don't continue comments

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
})

-- Remember cursor position between vim sessions
vim.cmd [[autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- Better colors
opt.termguicolors = true
-- Dark background
opt.background = 'dark'
-- Colorscheme
vim.cmd 'colorscheme Base2Tone_EveningDark'
-- vim.cmd 'colorscheme sitruuna'
-- Better window separators combined with global statusline
vim.cmd "highlight WinSeparator guibg=None"

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
