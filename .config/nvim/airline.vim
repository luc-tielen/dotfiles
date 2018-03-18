
" Airline configuration

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

