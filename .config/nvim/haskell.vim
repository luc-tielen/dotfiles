
" Haskell-specific config

let g:haskell_classic_highlighting = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_if = 2
let g:haskell_indent_case = 2
let g:haskell_indent_case_alternative = 1
let g:haskell_indent_let = 4
let g:haskell_indent_let_no_in = 4
let g:haskell_indent_in = 1
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_enable_backpack = 1
let g:neomake_haskell_enabled_makers = ['hlint']
let g:intero_start_immediately = 0
let g:intero_type_on_hover = 0
let g:intero_use_neomake = 1

" TODO hoogle integration

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
  au FileType haskell,lhaskell setlocal errorformat=g:haskell_project_errorformat
  au BufWritePost *.hs :call RunHasktagsIfExists()
augroup END

function! ReloadGhciIfStarted()
  if exists('g:intero_started') && g:intero_started == 1
    :InteroReload
  endif
endfunction

augroup ghciMaps
  au!
  " Background process and window management
  au FileType haskell,lhaskell nnoremap <silent> <leader>i :InteroStart<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>ik :InteroKill<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>ir :call ReloadGhciIfStarted()<CR>

  au BufWritePost *.hs :call ReloadGhciIfStarted()
augroup END

