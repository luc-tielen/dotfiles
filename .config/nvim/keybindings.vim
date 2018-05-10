
" Custom keybindings listed below:

" Disable arrow keys (forces hjkl):
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Shift + HJKL for quicker navigation
noremap H ^
noremap J 5j
noremap K 5k
noremap L g_

" Ctrl + HJKL for navigating across buffers/windows
noremap <C-h> <C-w><left>
noremap <C-j> <C-w><down>
noremap <C-k> <C-w><up>
noremap <C-l> <C-w><right>

" Navigating between vim buffers and tmux panels
" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
" nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
" tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
" tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
" tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
" tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
" tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

" Make ; same as : (no shift needed)
nnoremap ; :
vnoremap ; :

" No need for ex mode
nnoremap Q <nop>

" recording macros is not my thing
map q <Nop>

" Neovim terminal mapping
" terminal 'normal mode'
tmap <esc> <c-\><c-n><esc><cr>

" Copy to osx clipboard
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
noremap Y y$

" Faster escape out of insert mode:
inoremap jj <ESC>

" Better regexes:
nnoremap / /\v
vnoremap / /\v

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Disable highlight after search with enter
nnoremap <silent> <cr> :noh<cr><cr>

" Use tab in normal/visual mode to go to matching brackets:
nnoremap <tab> %
vnoremap <tab> %

" Shortcuts for tags
nnoremap <leader>t <C-]><CR>

" Bindings for multiple cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Skim keybindings
nnoremap <silent><c-p> :SK<CR>

" ,f to format code, requires formatters: read the docs
noremap <silent> <leader>f :Neoformat<CR>
" Tagbar bindings
nnoremap <F8> :TagbarToggle<CR>

" SuperTab like snippets behavior.
" TODO: ctrl space selects currently selected option
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" Ranger.vim config
let g:ranger_map_keys = 0
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1

