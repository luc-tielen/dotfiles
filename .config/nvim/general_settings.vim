
" Contains general settings for neovim

set nocompatible        " Use vim, not vi
let mapleader = ','     " leader is ,
set encoding=utf-8      " UTF-8 encoding in all files
set history=1000        " Remember last 1000 commands
set undolevels=1000     " Able to undo 1000 commands
set timeoutlen=200      " Shorter timeout when typing commands in normal mode

set title               " Change terminal title
set hidden              " Hide buffers instead of closing them
                        " => buffer can be in the background without being written
set shortmess=atI       " Dont short startup-message, shorten most info messages
set autoread            " Reload files when changed outside of vim
set nobackup            " Don't create backup files
set noswapfile          " Don't use a swap file
set novisualbell        " No visual bell  (flashing screen)
set noerrorbells        " No audible bell (beeps)
set laststatus=2        " Always show statusbar

set hlsearch            " Highlight during search
set ignorecase          " Ignore case when searching
set smartcase           " Don't ignore case if search contains a capital letter
set incsearch           " Incremental search (instantly show search results)

set gdefault            " Globally substitute by default

set splitbelow          " Opens new vertical windows below
set splitright          " Opens new horizontal windows right

set bs=indent,eol,start " Normal backspace

set number                        " Show linenumber
set norelativenumber              " Don't show relative linenumber
set numberwidth=1                 " Use at least 1 column for displaying numbers
set showmatch                     " Highlight matching {}, (), ...
set nocursorline                  " Don't show cursorline (for more speed..)
set nocursorcolumn                " Don't show cursorcolumn (for more speed..)

set lazyredraw                    " Only redraw new graphics (terminal only)
set ttyfast                       " Faster vim in terminal mode
set isfname-==

" Standard => tab = 2 spaces:
set autoindent                        " Copy indent previous line to next line
set tabstop=2                         " Tab = 2 chars long
set shiftwidth=2                      " Number of spaces to use for autoindent
set softtabstop=2                     " <BS> removes tabs (even if tab = spaces)
set expandtab                         " Change tabs to spaces
set smarttab                          " Tabs at start of line use shiftwidth
set wrap linebreak nolist             " Wrap around lines, only split on word-boundaries
set formatoptions+=t                  " Formatting options: auto-wrap text using textwidth
set inccommand=nosplit                " Show substitution on the fly, in same window
set virtualedit=                      " Only allow cursor where characters are

set wildmenu                          " Better command-line completion (when using ':')
set wildmode=full                     " Complete next match when tab is used (during ':')

set clipboard+=unnamedplus            " Use system clipboard
set nopaste                           " Auto-format when pasting

set foldlevel=99                      " Start everything unfolded by default

syntax on                         " Enable syntax coloring
syntax sync minlines=256          " Highlight 256 lines at a time
set synmaxcol=200                 " Highlight only first 200 characters of a line
set updatetime=500

" Indentation specific for certain files:
autocmd FileType mkd set ts=4 sw=4 sts=4 noet " Makefile:   tab = 4 wide (no spaces)
autocmd FileType python set ts=4 sw=4 sts=4   " Python:     tab = 4 spaces
autocmd FileType c set ts=4 sw=4 sts=4        " C:          tab = 4 spaces
autocmd FileType cpp set ts=4 sw=4 sts=4      " C++:        tab = 4 spaces

colorscheme Tomorrow-Night-Bright " Colorscheme to use
set background=dark               " Dark background

" Highlighting for 'special' file types:
autocmd BufRead,BufNewFile *.wsdl set filetype=xml

" Easily edit .vimrc:
map <leader>vim :new ~/.config/nvim/init.vim<cr>        " ,vim opens split with .vimrc
autocmd! BufWritePost ~/.config/nvim/init.vim :source % " After saving reload .vimrc

" Remember cursor position between vim sessions
autocmd BufReadPost *
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\   exe "normal! g'\"" |
			\ endif

" Center buffer around cursor when opening files:
autocmd BufRead * normal zz

" Deletes trailing whitespace before writing a buffer:
autocmd BufWritePre * %s/\s\+$//e

set complete=.,w,b,u,t,k  " Looks for matches in all buffer/windows and tags

" Changes working directory to that of currently used buffer (TODO fix)
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
