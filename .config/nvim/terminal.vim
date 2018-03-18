
" Terminal related configuration

" TODO
" - finish this
" - insert mode by default
" - normal mode when leaving

autocmd TermOpen * set bufhidden=hide  " Hide the terminal when buffer not shown anymore
autocmd BufWinEnter,WinEnter,BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert


