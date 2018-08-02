
" Skim related config

let g:skim_layout = {'down': '20%'}
autocmd! FileType skim tnoremap <buffer> <esc> <esc>:q

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number ' . shellescape(<q-args>), 0, {'dir': GetGitRootDir()})

" Helper functions for custom skim behaviour.
function GetGitRootDir()
  let root_dir = system("git rev-parse --show-toplevel")
  return split(root_dir, "\n")[0]
endfunction

function FuzzyFindFiles()
  let root_dir = GetGitRootDir()
  let cmd = "Files " . root_dir
  execute cmd
endfunction

