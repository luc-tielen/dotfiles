let mapleader = ' '  " Leader is <space>
set undolevels=1000     " Able to undo 1000 commands
set timeoutlen=200      " Shorter timeout when typing commands in normal mode
set autoread            " Reload files when changed outside of vim
set nobackup            " Don't create backup files
set noswapfile          " Don't use a swap file
set ignorecase          " Ignore case when searching
set smartcase           " Don't ignore case if search contains a capital letter
set gdefault            " Globally substitute by default
set nocursorline        " Don't show cursorline (for more speed..)
set nocursorcolumn      " Don't show cursorcolumn (for more speed..)
set autoindent          " Copy indent previous line to next line
set tabstop=2           " Tab = 2 chars long
set shiftwidth=2        " Number of spaces to use for autoindent
set softtabstop=2       " <BS> removes tabs (even if tab = spaces)

" Shift + HJKL for quicker navigation
noremap H ^
noremap J 5j
noremap K 5k
noremap L g_

" Use tab in normal/visual mode to go to matching brackets
nnoremap <tab> %
vnoremap <tab> %

" Go to symbol
nnoremap <silent> gs :call VSCodeNotify('workbench.action.gotoSymbol')<CR>

" Go to references
nnoremap <silent> gr :call VSCodeNotify('workbench.action.gotoReferences')<CR>

" Fuzzy search in files, use arrow keys + enter to open file
nnoremap <silent> <leader>g :call VSCodeNotify('fzf-quick-open.runFzfFile')<CR>
xnoremap <silent> <leader>g :call VSCodeNotify('fzf-quick-open.runFzfFile')<CR>

" Ctrl + HJKL for navigating across buffers/windows
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

" TODO make this work
nnoremap <silent> <M-h> :call VSCodeNotify('workbench.action.previousEditor')<CR>
xnoremap <silent> <M-h> :call VSCodeNotify('workbench.action.previousEditor')<CR>
nnoremap <silent> <M-l> :call VSCodeNotify('workbench.action.nextEditor')<CR>
xnoremap <silent> <M-l> :call VSCodeNotify('workbench.action.nextEditor')<CR>

" Alt + J/K to move line(s) down/up
nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap <A-up> <Esc>:m .-2<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv

" No need for ex mode
nnoremap Q <nop>

" recording macros is not my thing
map q <nop>

" Better regexes:
nnoremap / /\v
vnoremap / /\v

" TODO
" Disable highlight after search with enter
" nnoremap <silent> <cr> :noh<cr><cr>

" Renaming symbol
nnoremap <leader>r :call VSCodeNotify('editor.action.rename')<CR>
xnoremap <leader>r :call VSCodeNotify('editor.action.rename')<CR>

set clipboard+=unnamedplus            " Use system clipboard
set nopaste                           " Auto-format when pasting

