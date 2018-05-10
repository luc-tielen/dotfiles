
" Elixir-specific config

" TODO see daily drip for better config (phoenix.vim, alchemist.vim)
let g:neomake_elixir_enabled_markers = ['mix', 'credo']

augroup elixirBindings
  au!

  nnoremap <leader>h <C-k>             " Show help menu
  nnoremap <leader>gt <C-]>            " Go to definition under cursor
  nnoremap <leader>i :iex<cr>          " Open iex
  nnoremap <leader>c :mix compile<cr>  " Call mix compile
  nnoremap <leader>t :mix test<cr>     " Call mix test
augroup END


