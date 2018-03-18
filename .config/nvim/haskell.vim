
" Haskell-specific config

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

