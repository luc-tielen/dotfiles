
" NERDTree / NERDCommenter config

map <silent> <C-t> :NERDTreeToggle<CR>

augroup ntinit
	autocmd FileType nerdtree call s:nerdtreeinit()
augroup END
function! s:nerdtreeinit() abort
	nunmap <buffer> K
	nunmap <buffer> J
endf
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=45
let NERDTreeMinimalUI=1
let NERDTreeCascadeSingleChildDir=1
let NERDTreeCascadeOpenSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowIgnoredStatus=0
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeGitStatusNodeColorization = 1

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

