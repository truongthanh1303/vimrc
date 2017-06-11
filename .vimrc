" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

" don't make vim compatible with vi 
set nocompatible

" filetype func off
filetype off

" ---------------------- PLUGIN CONFIGURATION ----------------------
" initiate Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" start plugin defintion
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'itchyny/lightline.vim'      
Plugin 'Lokaltog/vim-easymotion'    
Plugin 'tpope/vim-surround'         
" -- Web Development
Plugin 'Shutnik/jshint2.vim'        
Plugin 'mattn/emmet-vim'            
Plugin 'kchmck/vim-coffee-script'   
Plugin 'groenewege/vim-less'        
Plugin 'skammer/vim-css-color'      
Plugin 'hail2u/vim-css3-syntax'     
Plugin 'digitaltoad/vim-jade'       

" end plugin definition
call vundle#end()            " required for vundle

filetype plugin indent on
filetype plugin on

let g:vimDir = $HOME.'/.vim'

let g:hardcoreMode = 0

let s:pluginDir  = g:vimDir.'/plugins/plugged'
let s:pluginDef  = g:vimDir.'/plugins/def.vim'
let s:pluginConf = g:vimDir.'/plugins/config.vim'

let s:configSetting = g:vimDir.'/config/setting.vim'
let s:configMapping = g:vimDir.'/config/mapping.vim'
let s:configAbbrev  = g:vimDir.'/config/abbrev.vim'
let s:configAutocmd  = g:vimDir.'/config/autocmd.vim'

let s:userConfig  = g:vimDir.'/local.vim'

if !isdirectory(s:pluginDir)

    " Welcome message when plugins are not yet installed

    echom " "
    echom "Welcome to WebVim"
    echom " > the vim IDE for web dev <"
    echom " "
    echom "Checking dependencies :"
    if (!executable('node') && !executable('nodejs')) || !executable('npm')
        echom " [ERR] node.js and npm are required, please install them before continuing."
    	echom " "
    else

        echom "  - nodejs   : ok"
        echom "  - npm      : ok"
        echom "  - eslint   : " . (executable('eslint')   ? "ok" : "no (optional)")
        echom "  - jsonlint : " . (executable('jsonlint') ? "ok" : "no (optional)")
        echom "  - csslint  : " . (executable('csslint')  ? "ok" : "no (optional)")
        echom " done."

        echom " "
        echom "We are going to install the plugins : "
        echom " 1. take a coffee"
        echom " 2. reload vim"
        echom " 3. Envoy WebVim"
        echom " "
        echom "Please note if you want to have the arrows keys and <esc>, disable the 'hardcoreMode' in the vimrc"
        echom " "

        exec ":source ".s:pluginDef

	"Install plugins on first run
	autocmd VimEnter * PlugInstall
    endif

else

    " Loads the global config, mapping and settings
    exec ":source ".s:configSetting
    exec ":source ".s:configMapping
    exec ":source ".s:configAbbrev
    exec ":source ".s:configAutocmd

    " Loads plugins def and config
    exec ":source ".s:pluginDef
    exec ":source ".s:pluginConf


    " user configuration
    if filereadable(s:userConfig)
       exec ":source ".s:userConfig
    endif

endif

" Copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" start NERDTree on start-up and focus active window
autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

" map FuzzyFinder
noremap <leader>b :FufBuffer<cr>
noremap <leader>f :FufFile<cr>

" use zencoding with <C-E>
let g:user_emmet_leader_key = '<c-e>'

" run JSHint when a file with .js extension is saved
" this requires the jsHint2 plugin
autocmd BufWritePost *.js silent :JSHint

" set the color theme to monokai
colorscheme monokai
" make a mark for column 80
set colorcolumn=80
" and set the mark color to DarkSlateGray
highlight ColorColumn ctermbg=lightgray guibg=lightgray

"---------------------------------------------------------

" turn on syntax highlighting
syntax on
" and show line numbers
set number

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" reload files changed outside vim
set autoread         

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" by default, in insert mode backspace won't delete over line breaks, or 
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" dont't unload buffers when they are abandoned, instead stay in the
" background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" ---------------------- CUSTOMIZATION ----------------------
"  The following are some extra mappings/configs to enhance my personal
"  VIM experience

" set , as mapleader
let mapleader = ","

" map <leader>q and <leader>w to buffer prev/next buffer
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default
" use ESC to remove search higlight
"nnoremap <esc> :noh<return><esc>

" most of the time I should use ` instead of ' but typing it with my keyabord
" is a pain, so just toggle them
"nnoremap ' `
"nnoremap ` '

" suggestion for normal mode commands
"set wildmode=list:longest

" keep the cursor visible within 3 lines when scrolling
"set scrolloff=3

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=2    " when reading, tabs are 2 spaces
set softtabstop=2   " in insert mode, tabs are 2 spaces

" no lines longer than 80 cols
set textwidth=80

" use <C-Space> for Vim's keyword autocomplete
"  ...in the terminal
inoremap <Nul> <C-n>
"  ...and in gui mode
inoremap <C-Space> <C-n>

" On file types...
"   .md files are markdown files
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
"   .twig files use html syntax
autocmd BufNewFile,BufRead *.twig setlocal ft=html
"   .less files use less syntax
autocmd BufNewFile,BufRead *.less setlocal ft=less
"   .jade files use jade syntax
autocmd BufNewFile,BufRead *.jade setlocal ft=jade
"   .jsx files use jade syntax
autocmd BufNewFile,BufRead *.jsx setlocal ft=javascript

" when pasting over SSH it's a pain to type :set paste and :set nopaste
" just map it to <f9>
set pastetoggle=<f9>

" select all mapping
"noremap <leader>a ggVG
set mouse=a
let g:NERDTreeMouseMode=3
