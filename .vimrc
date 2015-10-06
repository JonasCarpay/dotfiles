""""""""""""""""
""" Plugins: """
""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ddollar/nerdcommenter'
Plugin 'jnurmine/Zenburn'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-sleuth'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'SirVer/ultisnips' " Track the engine.
Plugin 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-endwise'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'marijnh/tern_for_vim'
Plugin 'Slava/vim-spacebars'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'rizzatti/dash.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""
""" Configuration """
"""""""""""""""""""""

""" General
set autoindent
set wrap
set nolist
set nocompatible
set linebreak
set breakindent
set shell=/bin/bash
set foldlevelstart=20
set scrolloff=5
let mapleader = "\<space>"
syntax enable
set hidden
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set nojoinspaces
set autoread
set nu
set backspace=2
" If you prefer the Omni-Completion tip window to close when a selection is made, these lines close it on movement in insert mode or when leaving insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let g:emmet_html5 = 1
let g:tex_flavor = "latex"
set wildignore+=*.aux,*.out,*.bbl,*.blg,*.fdb_latexmk,*.fls,*.log,*.pdf,*.run.xml,*.pyc
colorscheme solarized
set background=light
let g:airline_powerline_fonts = 1
let g:mustache_abbreviations = 1
set laststatus=2

"Set cursorline in normal mode
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul

""" Syntastic """
" Syntastic recommended defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic configuration
let g:syntastic_java_checkers=['checkstyle']
let g:syntastic_java_checkstyle_conf_file='~/Dev/SEM_46/checkstyle_cfg.xml'
let g:syntastic_java_checkstyle_classpath='/usr/local/Cellar/checkstyle/6.9/libexec/checkstyle-6.9-all.jar'
let g:syntastic_python_checkers=['pep8']
let g:syntastic_html_tidy_blocklevel_tags=['template']
nnoremap <leader>st :SyntasticToggleMode<CR>

""""""""""""""""""""
""" Key mappings """
""""""""""""""""""""
nnoremap <Leader>ch :nohl<CR>
nnoremap <Leader>w :wa<CR>
nnoremap <Leader>vs <C-w>v<C-w>l
nnoremap <Leader>hs <C-w>s<C-w>j
inoremap {<CR> {<CR>}<ESC>O
nnoremap <leader>fef gg=G''
nnoremap <Leader>gg :GitGutterToggle<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>

" Language-specific
nnoremap <leader>rr :w<CR>:!ruby %<CR>
nnoremap <leader>rp :w<CR>:!python %<CR>
autocmd FileType haskell nnoremap <leader>rh :w<CR>:!ghci %<CR>|inoremap >> <space>-><space>|inoremap << <space><-<space>
autocmd FileType javascript inoremap ({<CR> ({<CR>});<ESC>O
autocmd FileType html let g:user_emmet_leader_key = '<leader><leader>'

" Easy-align
vmap <Enter> <Plug>(LiveEasyAlign)

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-c>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

""" Navigation
inoremap hj <esc>
nnoremap j gj
nnoremap k gk
" Split navigation
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
" Split position
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

"""""""""""""""""
""" Functions """
"""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<CR>

""" Create non-existant parent directories on save
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
