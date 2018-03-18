
" Deoplete configuration

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:echodoc_enable_at_startup=1
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

