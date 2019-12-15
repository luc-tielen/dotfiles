
" Generic neomake configuration

call neomake#configure#automake('nirw', 500)

" Neomake keeps triggering continuous tests when running karma,
" so this disables it for javascript, yacc, ... buffers
autocmd FileType javascript :NeomakeDisableBuffer
autocmd FileType yacc :NeomakeDisableBuffer
autocmd FileType python :NeomakeDisableBuffer
autocmd FileType lua :NeomakeDisableBuffer
