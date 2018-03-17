
" Setup dein  ---------------------------------------------------------------{{{
if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
	call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
	call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

" TODO lazy loading of plugins to improve startup time
set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
call dein#begin(expand('~/.config/nvim'))
call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('flazz/vim-colorschemes')
"call dein#add('tmux-plugins/vim-tmux')
"call dein#add('christoomey/vim-tmux-navigator')
call dein#add('tpope/vim-fugitive')
call dein#add('rhysd/committia.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('lotabout/skim', {'build': './install --all', 'merged': 0})
call dein#add('lotabout/skim.vim', {'depends': 'skim'})
call dein#add('majutsushi/tagbar', {'on_cmd': 'TagBarToggle'})
" syntax
call dein#add('othree/html5.vim', {'on_ft': 'html'})
call dein#add('othree/yajs.vim', {'on_ft': 'js'})
call dein#add('elzr/vim-json', {'on_ft': 'json'})
call dein#add('elixir-lang/vim-elixir', {'on_ft': 'elixir'})
call dein#add('slashmili/alchemist.vim', {'on_ft': 'elixir'})
call dein#add('lambdatoast/elm.vim', {'on_ft': 'elm'})
call dein#add('neovimhaskell/haskell-vim', {'on_ft': 'haskell'})
call dein#add('parsonsmatt/intero-neovim', {'on_ft': 'haskell'})
call dein#add('Twinside/vim-hoogle', {'on_ft': 'haskell'})
call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
call dein#add('racer-rust/vim-racer', {'on_ft': 'rust'})
call dein#add('hail2u/vim-css3-syntax', {'on_ft': 'css'})
call dein#add('ap/vim-css-color', {'on_ft': 'css'})
call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
call dein#add('nelstrom/vim-markdown-folding', {'on_ft': 'markdown'})
call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})
call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
call dein#add('AndrewRadev/splitjoin.vim', {'on_map': {'n': ['gS', 'gJ']}})
call dein#add('neomake/neomake')
call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})
call dein#add('scrooloose/nerdcommenter')
" deoplete stuff
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/deol.nvim')

call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/echodoc.vim')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('MartinLafreniere/vim-PairTools')
call dein#add('martinda/Jenkinsfile-vim-syntax', {'on_ft': 'Jenkinsfile'})

" Focused editing:
call dein#add('junegunn/goyo.vim', {'on_cmd': 'Goyo'})
call dein#add('junegunn/limelight.vim', {'on_cmd': 'LimeLight'})

if dein#check_install()
	call dein#install()
	let pluginsExist=1
endif

call dein#end()
filetype plugin indent on
" }}}

" System Settings  ----------------------------------------------------------{{{
" Neovim Settings

set nocompatible        " Use vim, not vi
set encoding=utf-8      " UTF-8 encoding in all files
set history=1000        " Remember last 1000 commands
set undolevels=1000     " Able to undo 1000 commands
set timeoutlen=200      " Shorter timeout when typing commands in normal mode

set title               " Change terminal title
set hidden              " Hide buffers instead of closing them
                        " => buffer can be in the background without being written
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

set bs=indent,eol,start " Normal backspace

syntax on                         " Enable syntax coloring
syntax sync minlines=256          " Highlight 256 lines at a time
colorscheme Tomorrow-Night-Bright " Colorscheme to use
set background=dark               " Dark background
set synmaxcol=200                 " Highlight only first 200 characters of a line
set number                        " Show linenumber
set norelativenumber              " Don't show relative linenumber
set showmatch                     " Highlight matching {}, (), ...
set nocursorline                  " Don't show cursorline (for more speed..)
set nocursorcolumn                " Don't show cursorcolumn (for more speed..)

set lazyredraw                    " Only redraw new graphics (terminal only)
set ttyfast                       " Faster vim in terminal mode

" Standard => tab = 4 spaces:
set autoindent                        " Copy indent previous line to next line
set tabstop=4                         " Tab = 4 chars long
set shiftwidth=4                      " Number of spaces to use for autoindent
set softtabstop=4                     " <BS> removes tabs (even if tab = spaces)
set expandtab                         " Change tabs to spaces
set smarttab                          " Tabs at start of line use shiftwidth

" Indentation specific for certain files:
autocmd FileType mkd set ts=4 sw=4 sts=4 noet " Makefile:   tab = 4 wide (no spaces)
autocmd FileType elixir set ts=2 sw=2 sts=2   " Elixir:     tab = 2 spaces
autocmd FileType ruby set ts=2 sw=2 sts=2     " Ruby:       tab = 2 spaces
autocmd FileType lua set ts=2 sw=2 sts=2      " Lua:        tab = 2 spaces
autocmd FileType moon set ts=2 sw=2 sts=2     " Moonscript: tab = 2 spaces
autocmd FileType html set ts=2 sw=2 sts=2     " HTML:       tab = 2 spaces
autocmd FileType js set ts=2 sw=2 sts=2       " JS:         tab = 2 spaces
autocmd FileType jsx set ts=2 sw=2 sts=2      " JSX:        tab = 2 spaces

" Highlighting for 'special' file types:
autocmd BufRead,BufNewFile *.wsdl set filetype=xml

" Easily edit .vimrc:
map <leader>vim :new ~/.config/nvim/init.vim<cr>        " ,vim opens split with .vimrc
autocmd! BufWritePost ~/.config/nvim/init.vim :source % " After saving reload .vimrc

" Enable mouse support:
if has("mouse")
	set mouse=a
endif

set termguicolors             " use real colors
set guioptions-=m             " No menubar at the top
set guioptions-=T             " No toolbar at the top
set guioptions-=r             " No scrollbar on the right side
set guioptions-=l             " No scrollbar on the left side
set guioptions-=L             " No scrollbar on the left side (when there is a
                              " vertically split window)
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set clipboard+=unnamedplus
set nopaste
autocmd BufWritePre * %s/\s\+$//e
filetype on
set number
set numberwidth=1
set virtualedit=
set wildmenu
set wildmode=full
set wrap linebreak nolist
set autoread
set updatetime=500
" leader is ,
let mapleader = ','
" Remember cursor position between vim sessions
autocmd BufReadPost *
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\   exe "normal! g'\"" |
			\ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz
set complete=.,w,b,u,t,k
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
set formatoptions+=t
set inccommand=nosplit
set shortmess=atIc
set isfname-==

" }}}

" System mappings  ----------------------------------------------------------{{{
" No need for ex mode
nnoremap Q <nop>
" recording macros is not my thing
map q <Nop>
" Neovim terminal mapping
" terminal 'normal mode'
tmap <esc> <c-\><c-n><esc><cr>
" Shift + HJKL for quicker navigation
noremap H ^
noremap J 5j
noremap K 5k
noremap L g_
" Make ; same as : (no shift needed)
nnoremap ; :
" Copy to osx clipboard
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
noremap Y y$
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

nnoremap <silent><c-p> :SK<CR>
nnoremap <F8> :TagbarToggle<CR>

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

" Better regexes:
nnoremap / /\v
vnoremap / /\v

" Disable highlight after search with enter
nnoremap <silent> <cr> :noh<cr><cr>

" Use tab in normal/visual mode to go to matching brackets:
nnoremap <tab> %
vnoremap <tab> %

" Shortcuts for tags
nnoremap <leader>t <C-]><CR>

" Easier shortcut to copy / paste to vim from clipboard
vnoremap <C-c> "+y<CR>
nnoremap <C-v> "*p<CR>

"}}}"

" Code formatting -----------------------------------------------------------{{{

" ,f to format code, requires formatters: read the docs
noremap <silent> <leader>f :Neoformat<CR>
" }}}

" Folds  ---------------------------------------------------------------------{{{

set foldlevel=99
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" }}}

" Git -----------------------------------------------------------------------{{{

set signcolumn=yes
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_removed_first_line = '|'
let g:gitgutter_sign_modified_removed = '│'
let g:committia_open_only_vim_starting=1

" }}}

" NERDTree ------------------------------------------------------------------{{{
map <silent> <c-t> :NERDTreeToggle<CR>

augroup ntinit
	autocmd FileType nerdtree call s:nerdtreeinit()
augroup END
function! s:nerdtreeinit() abort
	nunmap <buffer> K
	nunmap <buffer> J
endf
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=45
let NERDTreeMinimalUI=1
let NERDTreeCascadeSingleChildDir=1
let NERDTreeCascadeOpenSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowIgnoredStatus=0
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeGitStatusNodeColorization = 1

" }}}

" NERDcommenter -------------------------------------------------------------{{{

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

vnoremap <leader>/ :<C-U><plug>NERDComInvertComment()<cr>
"}}}

" Skim fuzzy finder ---------------------------------------------------------{{{

let g:skim_layout = {'down': '20%'}
autocmd! FileType skim tnoremap <buffer> <esc> <esc>:q

" }}}

" Nvim terminal -------------------------------------------------------------{{{

au BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd BufEnter term://* startinsert
autocmd TermOpen * set bufhidden=hide

" }}}

" Snippets -----------------------------------------------------------------{{{

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

"}}}

" Deoplete ------------------------------------------------------------------{{{

" enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:echodoc_enable_at_startup=1
set splitbelow
set splitright
set completeopt+=noselect,menuone
set completeopt-=preview
autocmd CompleteDone * pclose

function! Multiple_cursors_before()
	let b:deoplete_disable_auto_complete=2
endfunction
function! Multiple_cursors_after()
	let b:deoplete_disable_auto_complete=0
endfunction
let g:deoplete#file#enable_buffer_path=1
call deoplete#custom#source('buffer', 'mark', 'ℬ')
call deoplete#custom#source('tern', 'mark', '')
call deoplete#custom#source('omni', 'mark', '⌾')
call deoplete#custom#source('file', 'mark', '')
call deoplete#custom#source('jedi', 'mark', '')
call deoplete#custom#source('neosnippet', 'mark', '')
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.html = ''
let g:deoplete#omni_patterns.css = ''
function! Preview_func()
	if &pvw
		setlocal nonumber norelativenumber
	endif
endfunction
autocmd WinEnter * call Preview_func()
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['around']

"}}}


let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"}}}

" Navigate between vim buffers and tmux panels ------------------------------{{{

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

"}}}

" vim-airline ---------------------------------------------------------------{{{

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"let g:airline_theme='one'
let g:airline_powerline_fonts = 1
let g:airline_symbols.branch = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline_detect_spelllang=0
let g:airline_detect_spell=0
set noshowmode  " let airline show status mode

"}}}

" MultiCursor ---------------------------------------------------------------{{{

let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
"}}}

" Javascript ----------------------------------------------------------------{{{

"let g:neoformat_javascript_prettier = g:standard_prettier_settings
let g:neoformat_enabled_javascript = ['prettier']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:jsx_ext_required = 1

" }}}

" JSON ----------------------------------------------------------------------{{{

let g:vim_json_syntax_conceal = 0

" }}}

" HTML ----------------------------------------------------------------------{{{

let g:neomake_html_enabled_makers = []
let g:neoformat_enabled_html = ['htmlbeautify']

" }}}

" CSS -----------------------------------------------------------------------{{{

"let g:neoformat_scss_prettier = g:standard_prettier_settings
let g:neoformat_enabled_scss = ['prettier']
let g:neomake_scss_enabled_makers = ['sass-lint']

"}}}


" Python --------------------------------------------------------------------{{{

let g:python_host_prog = '/usr/local/bin/python'
let g:jedi#auto_vim_configuration = 0
let g:jedi#documentation_command = "<leader>h"
let g:jedi#completions_enabled = 0
" }}}

" Rust ----------------------------------------------------------------------{{{
let g:racer_cmd = '/Users/mhartington/.cargo/bin/racer'

"}}}


" Haskell -------------------------------------------------------------------{{{

let g:neoformat_enabled_haskell = ['hindent', 'stylishhaskell']
let g:neomake_haskell_enabled_makers = ['hlint']
let g:intero_start_immediately = 0

function! RunHasktagsIfExists()
  " Only regenerate existing tags.
  if filereadable('tags')
    call system('hasktags --ctags .')
  endif
endfunction

let g:haskell_project_errorformat = '%E%f:%l:%c:\ error:%#,' .
      \ '%W%f:%l:%c:\ warning:%#,' .
      \ '%W%f:%l:%c:\ warning:\ [-W%.%#]%#,' .
      \ '%f:%l:%c:\ %terror: %m,' .
      \ '%f:%l:%c:\ %twarning: %m,' .
      \ '%E%f:%l:%c:%#,' .
      \ '%E%f:%l:%c:%m,' .
      \ '%W%f:%l:%c:\ Warning:%#,' .
      \ '%C\ \ %m%#,' .
      \ '%-G%.%#'

augroup HaskellMaps
  au FileType haskell setlocal formatprg=hindent
  au FileType haskell,lhaskell setlocal errorformat=g:haskell_project_errorformat
  au BufWritePost *.hs :call RunHasktagsIfExists()
augroup END

function! ReloadGhciIfStarted()
  if exists('g:intero_started')
    :InteroReload
  endif
endfunction

augroup ghciMaps
  au!
  " Background process and window management
  au FileType haskell,lhaskell nnoremap <silent> <leader>gs :InteroStart<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gk :InteroKill<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gr :InteroRestart<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gos :InteroOpen<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gov :InteroOpen<CR><C-W>H
  au FileType haskell,lhaskell nnoremap <silent> <leader>gh :InteroHide<CR>

  au BufWritePost *.hs :call ReloadGhciIfStarted()

  " Type-related information
  au FileType haskell,lhaskell map <silent> <leader>gt <Plug>InteroGenericType
  au FileType haskell,lhaskell map <silent> <leader>gT <Plug>InteroType
  au FileType haskell,lhaskell map <silent> <leader>gi :InteroInfo<CR>
  au FileType haskell,lhaskell map <silent> <leader>gI :InteroTypeInsert<CR>

augroup END
" }}}


" Elixir -------------------------------------------------------------------{{{



" }}}
