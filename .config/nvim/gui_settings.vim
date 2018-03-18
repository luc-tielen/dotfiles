
" GUI-only vim configuration

" Enable mouse support:
if has("mouse")
	set mouse=a
endif

set termguicolors             " use real colors
set guioptions-=m             " No menubar at the top
set guioptions-=T             " No toolbar at the top
set guioptions-=r             " No scrollbar on the right side
set guioptions-=l             " No scrollbar on the left side
set guioptions-=L             " No scrollbar on the left side (when there is a
                              " vertically split window)
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
