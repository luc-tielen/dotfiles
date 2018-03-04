
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
"call dein#add('flazz/vim-colorschemes')
call dein#add('junegunn/vim-easy-align', {'on_map': {'n': ['ga'], 'v': ['ga']}})
call dein#add('majutsushi/tagbar', {'on_cmd': 'TagBarToggle'})
" syntax
call dein#add('othree/html5.vim', {'on_ft': 'html'})
call dein#add('othree/yajs.vim', {'on_ft': 'js'})
call dein#add('elzr/vim-json', {'on_ft': 'json'})
call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
call dein#add('racer-rust/vim-racer', {'on_ft': 'rust'})
call dein#add('hail2u/vim-css3-syntax', {'on_ft': 'css'})
call dein#add('ap/vim-css-color', {'on_ft': 'css'})
call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
call dein#add('nelstrom/vim-markdown-folding', {'on_ft': 'markdown'})
call dein#add('rhysd/vim-grammarous', {'on_cmd': 'GrammarousCheck'})
call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
"call dein#add('tmux-plugins/vim-tmux')
"call dein#add('christoomey/vim-tmux-navigator')
call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})
call dein#add('tpope/vim-fugitive', {'on_cmd': ['GDiff', 'GBlame', 'GStatus', 'GGrep']})
call dein#add('rhysd/committia.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
call dein#add('AndrewRadev/splitjoin.vim', {'on_map': {'n': ['gS', 'gJ']}})
call dein#add('neomake/neomake', {'on_cmd': 'NeoMake'})
call dein#add('scrooloose/nerdcommenter')
call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})
" deoplete stuff
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/deol.nvim')
call dein#add('Shougo/denite.nvim')

call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/echodoc.vim')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('MartinLafreniere/vim-PairTools')
call dein#add('vim-airline/vim-airline')
call dein#add('junegunn/fzf')

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
set termguicolors
set mouse=a
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set clipboard+=unnamedplus
set nopaste
autocmd BufWritePre * %s/\s\+$//e
" let airline show status mode
set noshowmode
set noswapfile
filetype on
set number
set numberwidth=1
set tabstop=2 shiftwidth=2 expandtab
set virtualedit=
set wildmenu
set wildmode=full
set laststatus=2
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

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
vnoremap <leader>/ :TComment<cr>
vnoremap <c-/> :TComment<cr>
nnoremap <leader><space> :noh<cr>
vnoremap <leader>ga <Plug>(EasyAlign)
nnoremap <F8> :TagbarToggle<CR>
"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
syntax on
colorscheme candycode
set background=dark
"}}}

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
map <silent> <leader>t :NERDTreeToggle<CR>

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
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowIgnoredStatus=0
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeGitStatusNodeColorization = 1
" }}}

"}}}

" Nvim terminal -------------------------------------------------------------{{{

au BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd BufEnter term://* startinsert
autocmd TermOpen * set bufhidden=hide

" }}}

" Snipppets -----------------------------------------------------------------{{{

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

" Denite --------------------------------------------------------------------{{{

let s:menus = {}
call denite#custom#option('_', {
			\ 'prompt': '❯',
			\ 'winheight': 10,
			\ 'updatetime': 1,
			\ 'auto_resize': 0,
			\ 'highlight_matched_char': 'Underlined',
			\ 'highlight_mode_normal': 'CursorLine',
			\ 'reversed': 1,
			\})
call denite#custom#option('TSDocumentSymbol', {
			\ 'prompt': ' @' ,
			\ 'reversed': 0,
			\})
call denite#custom#option('TSWorkspaceSymbol', {
			\ 'reversed': 0,
			\ 'prompt': ' #' ,
			\})
call denite#custom#source('file_rec', 'vars', {
			\ 'command': [
			\ 'ag', '--follow','--nogroup','--hidden', '--column', '-g', '', '--ignore', '.git', '--ignore', '*.png', '--ignore', 'node_modules'
			\] })
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap <silent> <c-p> :Denite file_rec<CR>
nnoremap <silent> <leader>h :Denite  help<CR>
nnoremap <silent> <leader>c :Denite colorscheme<CR>
nnoremap <silent> <leader>b :Denite buffer<CR>
nnoremap <silent> <leader>a :Denite grep:::!<CR>
nnoremap <silent> <leader>u :call dein#update()<CR>
nnoremap <silent> <Leader>i :Denite menu:ionic <CR>
call denite#custom#map('insert','<C-n>','<denite:move_to_next_line>','noremap')
call denite#custom#map('insert','<C-p>','<denite:move_to_previous_line>','noremap')
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
			\ [ '.git/', '.ropeproject/', '__pycache__/',
			\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
call denite#custom#var('menu', 'menus', s:menus)
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"}}}

" Git from denite... --------------------------------------------------------{{{
let s:menus.git = {
			\ 'description' : 'Fugitive interface',
			\}
let s:menus.git.command_candidates = [
			\[' git status', 'Gstatus'],
			\[' git diff', 'Gvdiff'],
			\[' git commit', 'Gcommit'],
			\[' git stage/add', 'Gwrite'],
			\[' git checkout', 'Gread'],
			\[' git rm', 'Gremove'],
			\[' git cd', 'Gcd'],
			\[' git push', 'exe "Git! push " input("remote/branch: ")'],
			\[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
			\[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
			\[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
			\[' git fetch', 'Gfetch'],
			\[' git merge', 'Gmerge'],
			\[' git browse', 'Gbrowse'],
			\[' git head', 'Gedit HEAD^'],
			\[' git parent', 'edit %:h'],
			\[' git log commit buffers', 'Glog --'],
			\[' git log current file', 'Glog -- %'],
			\[' git log last n commits', 'exe "Glog -" input("num: ")'],
			\[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
			\[' git log until date', 'exe "Glog --until=" input("day: ")'],
			\[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
			\[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
			\[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
			\[' git mv', 'exe "Gmove " input("destination: ")'],
			\[' git grep',  'exe "Ggrep " input("string: ")'],
			\[' git prompt', 'exe "Git! " input("command: ")'],
			\] " Append ' --' after log to get commit info commit buffers
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

set hidden
"let g:airline_theme='one'
let g:airline_powerline_fonts = 1
let g:airline_symbols.branch = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline_detect_spelllang=0
let g:airline_detect_spell=0

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
let g:jedi#documentation_command = "<leader>k"
let g:jedi#completions_enabled = 0
" }}}

" Rust ----------------------------------------------------------------------{{{
let g:racer_cmd = '/Users/mhartington/.cargo/bin/racer'

"}}}

