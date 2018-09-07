"hi Tag              guifg=#bd9800   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=11      ctermbg=NONE    cterm=NONE
"hi xmlTag           guifg=#bd9800   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=11      ctermbg=NONE    cterm=NONE
"hi xmlTagName       guifg=#bd9800   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=11      ctermbg=NONE    cterm=NONE
"hi xmlEndTag        guifg=#bd9800   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=11      ctermbg=NONE    cterm=NONE

"syn region xmlTagName matchgroup=xmlEndTag start=+</+ end=+>+

hi link xmlEndTag xmlTag
