
" Generic neomake configuration

call neomake#configure#automake('nirw', 500)

" Neomake keeps triggering continuous tests when running karma,
" so this disable it for javascript buffers
autocmd FileType javascript :NeomakeDisableBuffer
