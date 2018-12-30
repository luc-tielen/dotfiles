
" Setups dein + installs plugins
" Most plugins are lazy loaded for better startup times

if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
	call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
	call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.config/nvim'))
" Dein
call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim')
" Theme
call dein#add('luc-tielen/ayu-vim')
call dein#add('vim-airline/vim-airline')
call dein#add('flazz/vim-colorschemes')
" Neo* plugins
call dein#add('neomake/neomake')
call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
" Git plugins
call dein#add('tpope/vim-fugitive')
call dein#add('rhysd/committia.vim')
call dein#add('airblade/vim-gitgutter')
" Filesystem related plugins
call dein#add('francoiscabrol/ranger.vim')
call dein#add('lotabout/skim', {'build': './install --all', 'merged': 0})
call dein#add('lotabout/skim.vim', {'depends': 'skim'})
call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
call dein#add('majutsushi/tagbar', {'on_cmd': 'TagBarToggle'})
" Keyboard shortcuts
call dein#add('AndrewRadev/splitjoin.vim', {'on_map': {'n': ['gS', 'gJ']}})
call dein#add('MartinLafreniere/vim-PairTools')
"call dein#add('scrooloose/nerdcommenter')
"call dein#add('terryma/vim-multiple-cursors')
" Syntax
call dein#add('othree/html5.vim', {'on_ft': 'html'})
"call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript'})
call dein#add('mxw/vim-jsx', {'on_ft': 'javascript'})
call dein#add('prettier/vim-prettier', {'on_ft': 'javascript', 'build': 'yarn install'})
call dein#add('elzr/vim-json', {'on_ft': 'json'})
call dein#add('kchmck/vim-coffee-script', {'on_ft': 'coffee'})
call dein#add('hail2u/vim-css3-syntax', {'on_ft': 'css'})
call dein#add('ap/vim-css-color', {'on_ft': ['css', 'scss']})
call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
call dein#add('nelstrom/vim-markdown-folding', {'on_ft': 'markdown'})
call dein#add('jxnblk/vim-mdx-js', {'on_ft': 'mdx'})
call dein#add('elixir-lang/vim-elixir', {'on_ft': 'elixir'})
call dein#add('slashmili/alchemist.vim', {'on_ft': 'elixir'})
call dein#add('luc-tielen/elm-vim', {'on_ft': 'elm'})
call dein#add('neovimhaskell/haskell-vim', {'on_ft': 'haskell'})
call dein#add('parsonsmatt/intero-neovim', {'on_ft': 'haskell'})
call dein#add('Twinside/vim-hoogle', {'on_ft': 'haskell'})
call dein#add('nbouscal/vim-stylish-haskell', {'on_ft': 'haskell'})
call dein#add('raichoo/purescript-vim.git', {'on_ft': 'purescript'})
call dein#add('FrigoEU/psc-ide-vim', {'on_ft': 'purescript'})
call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
call dein#add('racer-rust/vim-racer', {'on_ft': 'rust'})
call dein#add('hashivim/vim-terraform', {'on_ft': 'terraform'})
call dein#add('martinda/Jenkinsfile-vim-syntax', {'on_ft': 'Jenkinsfile'})
" Focused editing:
call dein#add('junegunn/goyo.vim', {'on_cmd': 'Goyo'})
call dein#add('junegunn/limelight.vim', {'on_cmd': 'LimeLight'})

if dein#check_install()
	call dein#install()
	let pluginsExist=1
endif

call dein#end()
filetype plugin indent on
