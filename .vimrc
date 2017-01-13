" General settings {{{

set nocompatible        " Use vim, not vi
let mapleader=','       " Use , as leader button.

set history=1000        " Remember last 1000 commands
set undolevels=1000     " Able to undo 1000 commands
set timeoutlen=200      " Shorter timeout when typing commands in normal mode
set clipboard+=unnamed  " Yanks go to clipboard
set encoding=utf-8      " UTF-8 encoding in all files

set title               " Change terminal title
set hidden              " Hide buffers instead of closing them
                        " => buffer can be in the background without being written
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

set bs=indent,eol,start " Normal backspace

syntax on                     " Enable syntax coloring
syntax sync minlines=256      " Highlight 256 lines at a time
set synmaxcol=200             " Highlight only first 200 characters of a line
set number                    " Show linenumber
set norelativenumber          " Don't show relative linenumber
set showmatch                 " Highlight matching {}, (), ...
set nocursorline              " Don't show cursorline (for more speed..)
set nocursorcolumn            " Don't show cursorcolumn (for more speed..)

set nowrap                    " Disable visual wrapping
"set colorcolumn=80           " Highlight column 80 (slows down slightly?)
set textwidth=79 wrapmargin=0 " Enable wrapping of lines (80+ chars per line)         

set autoread                  " Reload files when changed outside of vim

set lazyredraw                " Only redraw new graphics (terminal only)
set ttyfast                   " Faster vim in terminal mode

" Easily edit .vimrc:
map <leader>vim :new ~/.vimrc<cr>        " ,vim opens split with .vimrc
autocmd! BufWritePost ~/.vimrc :source % " After saving reload .vimrc

" Enable mouse support:
if has("mouse")
	set mouse=a
endif

" Save cursor position:
augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" }}}

" GUI related options (gvim) {{{

set guioptions-=m             " No menubar at the top
set guioptions-=T             " No toolbar at the top
set guioptions-=r             " No scrollbar on the right side
set guioptions-=l             " No scrollbar on the left side
set guioptions-=L             " No scrollbar on the left side (when there is a
                              " vertically split window)
set guifont=Inconsolata-g\ 12 " Great looking font, size = 12.

" if small discolored bar on the right or bottom shows up, 
" edit ~/.gtkrc-2.0 to fix the color!


" }}}

" Plugins {{{

filetype off                      " Disable filetype until plugins are
                                  " loaded => see below (needed for Vundle)
set rtp+=~/.vim/bundle/vundle.vim " Add Vundle to the path

call vundle#begin()                    
" Start of Vundle plugins
Plugin 'gmarik/vundle.vim'                  " Allow Vundle to update itself
Plugin 'bling/vim-airline'                  " Better statusbar
Plugin 'tpope/vim-fugitive'                 " Git plugin
Plugin 'kien/ctrlp.vim'                     " Fuzzy searcher
Plugin 'scrooloose/nerdtree'                " Tree explorer plugin
Plugin 'scrooloose/nerdcommenter'           " Easily (un)comment text
Plugin 'Valloric/YouCompleteMe'             " Autocompletion plugin
Plugin 'scrooloose/syntastic'               " Syntax checking
Plugin 'Sirver/ultisnips'                   " Snippets support (requires python)
Plugin 'vim-erlang/vim-erlang-omnicomplete' " Erlang autocompletion
Plugin 'elixir-lang/vim-elixir'             " Elixir support for vim
Plugin 'mattreduce/vim-mix'                 " Mix support for vim
Plugin 'rust-lang/rust.vim'                 " Rust support for vim
Plugin 'petRUShka/vim-opencl'               " OpenCL support for vim
Plugin 'kergoth/vim-bitbake'                " Yocto/Bitbake plugin
Plugin 'leafo/moonscript-vim'               " Moonscript highlight + indent
" End of Vundle plugins
call vundle#end()   

filetype plugin indent on              " Custom indentation based on filetype

" Vim airline config:
let g:airline_powerline_fonts=1        " Enable powerline fonts on vim-airline
let g:airline_exclude_preview = 0      " Reduce flickering from buffer
" let g:airline_theme='theme_name_here'

" Ultisnips config:
let g:UltiSnipsExpandTrigger='<tab>'         " Start snippet with tab 
let g:UltiSnipsJumpForwardTrigger='<tab>'    " Next position in snippet = tab
let g:UltiSnipsJumpBackwardTrigger='<s-tab>' " Shift tab for previous position
let g:ultisnips_java_brace_style='nl'        " Start { on newline in Java files

" Autocompletion using ctrl space:
"set omnifunc=syntaxcomplete#Complete
inoremap <C-space> <C-x><C-o>
inoremap <C-@> <C-space>

" Automatically close preview window after autocompletion:
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Nerd Tree config
set autochdir               " Automatically change the current working directory 
                            " to the directory where you're editing a file
let NERDTreeChDirMode=2
map <C-t> :NERDTreeToggle<CR> " Ctrl-t triggers nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Colorscheme plugin:
" TODO change colorscheme based on filetypes!
" colorscheme badwolf
colorscheme wombat256mod
set background=dark

" }}}

" Indentation {{{

" Standard => tab = 4 spaces:
set autoindent                        " Copy indent previous line to next line
set tabstop=4                         " Tab = 4 chars long
set shiftwidth=4                      " Number of spaces to use for autoindent
set softtabstop=4                     " <BS> removes tabs (even if tab = spaces)
set expandtab                         " Change tabs to spaces
set smarttab                          " Tabs at start of line use shiftwidth
                                      " instead of tabstop

" Indentation specific for certain files:
autocmd FileType mkd set ts=4 sw=4 sts=4 noet " Makefile:   tab = 4 wide (no spaces)
autocmd FileType ruby set ts=2 sw=2 sts=2     " Ruby:       tab = 2 spaces
autocmd FileType lua set ts=2 sw=2 sts=2      " Lua:        tab = 2 spaces
autocmd FileType moon set ts=2 sw=2 sts=2     " Moonscript: tab = 2 spaces
autocmd FileType html set ts=2 sw=2 sts=2     " HTML:       tab = 2 spaces

" }}}

" Remapped controls / shortcuts {{{

" Disable arrow keys (forces hjkl):
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Faster escape out of insert mode:
inoremap jj <ESC>

" Scroll viewport faster up and down:
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Better regexes:
nnoremap / /\v
vnoremap / /\v

" Disable highlight after search with ,space
nnoremap <leader><space> :noh<cr>  

" Use tab in normal/visual mode to go to matching brackets:
nnoremap <tab> %
vnoremap <tab> %

" Shortcuts for tags
nnoremap <leader>t <C-]><CR>

" Easier shortcut to copy paste to vim from clipboard
nnoremap <C-v> "*p<CR>
vnoremap <C-c> "+y<CR>
" }}}
