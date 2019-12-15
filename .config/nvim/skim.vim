
" Skim related config

let g:skim_layout = {'down': '20%'}
autocmd! FileType skim tnoremap <buffer> <esc> <esc>:q

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number ' . shellescape(<q-args>), 0, {'dir': GetGitRootDir()})

" Helper functions for custom skim behaviour.
function! GetGitRootDir()
  let s:root_dir = system("git rev-parse --show-toplevel")
  return split(s:root_dir, "\n")[0]
endfunction

" NOTE: looks both in committed and uncommitted files
function FuzzyFindFiles()
  let s:root_dir = GetGitRootDir()
  let s:options = '-c -o'
  let s:gitignore = s:root_dir . '/.gitignore'

  if filereadable(s:gitignore)
    call fzf#vim#gitfiles(s:options . ' -X ' . s:gitignore)
    return
  endif

  call fzf#vim#gitfiles(s:options)
endfunction

