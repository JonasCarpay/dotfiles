" NeoBundle  {{{
	" Boilerplate {{{
		" If vundle is not installed, do it first
		let bundleExists = 1
		if (!isdirectory(expand("$HOME/.nvim/bundle/neobundle.vim")))
			call system(expand("mkdir -p $HOME/.nvim/bundle"))
			call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim"))
			let bundleExists = 0
		endif

		if 0 | endif

		if has('vim_starting')
			if &compatible
				" Be iMproved
				set nocompatible
			endif

			" Required:
			set runtimepath+=~/.nvim/bundle/neobundle.vim/
			" set runtimepath+=~/.nvim/bundle/bolt.vim/
		endif

		" Required:
		call neobundle#begin(expand('~/.nvim/bundle/'))

		" Let NeoBundle manage NeoBundle
		" Required:
		NeoBundleFetch 'Shougo/neobundle.vim'
	" Boilerplate }}}

		" Helpers
		  NeoBundle 'tpope/vim-unimpaired'
		  NeoBundle 'tpope/vim-repeat'

		" Git helpers
		  NeoBundle 'tpope/vim-fugitive'
		  NeoBundle 'airblade/vim-gitgutter'

		" File navigation
		  NeoBundle 'scrooloose/nerdtree'
		  NeoBundle 'Xuyuanp/nerdtree-git-plugin'
		  NeoBundle 'ryanoasis/vim-devicons'
		  NeoBundle 'tpope/vim-eunuch'
		  NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }
		  NeoBundle 'junegunn/fzf.vim'

		" Syntax and highlighting
		  NeoBundle 'altercation/vim-colors-solarized'
		  NeoBundle 'benekastah/neomake'
		  NeoBundle 'Valloric/YouCompleteMe'
		  let g:EclimCompletionMethod = 'omnifunc'
		  NeoBundle 'ntpeters/vim-better-whitespace'

		" Editing
		  NeoBundle 'tpope/vim-surround'
		  NeoBundle 'Lokaltog/vim-easymotion'
		  NeoBundle 'junegunn/vim-easy-align'
		  NeoBundle 'SirVer/ultisnips'
		  let g:UltiSnipsUsePythonVersion = 2
		  NeoBundle 'honza/vim-snippets'
		  NeoBundle 'tpope/vim-sleuth'
		  NeoBundle 'michaeljsmith/vim-indent-object'

		" Language-specific
		  NeoBundle 'neovimhaskell/haskell-vim'
		  NeoBundle 'enomsg/vim-haskellConcealPlus'
		  NeoBundle 'mattn/emmet-vim'
		  NeoBundle 'Slava/vim-spacebars'

		" Other
		  NeoBundle 'bling/vim-airline'
		  NeoBundle 'marijnh/tern_for_vim'
		  NeoBundle 'jeetsukumaran/vim-indentwise'
		  NeoBundle 'jeetsukumaran/vim-buffergator'

	" Boilerplate {{{
		" Required:
		call neobundle#end()
		filetype plugin indent on
		NeoBundleCheck
		if bundleExists == 0
			echo "Installing Bundles, ignore errors"
		endif
	" Boilerplate }}}
" NeoBundle }}}
" System settings {{{
	syntax enable
	set number
	set wrap nolist linebreak breakindent
	set incsearch hlsearch ignorecase smartcase
	set background=dark
	let g:tex_flavor = "latex"
	colorscheme solarized
	let g:airline_powerline_fonts = 1
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" }}}
" Key bindings {{{
	let mapleader = "\<space>"
	inoremap hj <esc>
	vnoremap hj <esc>
	inoremap HJ <esc>
	inoremap Hj <esc>

	nnoremap <Leader>ch :nohl<CR>
	nnoremap <Leader>w :wa<CR>
	nnoremap <Leader>vs <C-w>v<C-w>l
	nnoremap <Leader>hs <C-w>s<C-w>j
	nnoremap <Leader>n :NERDTreeToggle<CR>

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

	" Git/gutter/fugitive
	nnoremap <Leader>gt :GitGutterToggle<CR>
	nnoremap <Leader>gs :Gstatus<CR>
	nnoremap <Leader>gc :Gcommit<CR>
	nnoremap <Leader>gd :Gdiff<CR>

	" Easy-align
	vmap <Enter> <Plug>(LiveEasyAlign)

	" Ultisnips
	let g:UltiSnipsExpandTrigger="<c-c>"
	let g:UltiSnipsJumpForwardTrigger="<c-b>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"

	" Remaps {{{
		vnoremap > >gv
		vnoremap < <gv
		nnoremap Q <nop>
		nnoremap , za
		nnoremap j gj
		nnoremap k gk
	" Remaps }}}
" Key bindings }}}
" Autocmds and functions {{{
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevel=0
	autocmd! BufWritePost * Neomake
" }}}
" Plugin-specific {{{
	" NERDTree {{{
		autocmd StdinReadPre * let s:std_in=1
		autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && !empty(glob(".git")) | NERDTree | endif
		let NERDTreeShowHidden=1

		" NERDTress File highlighting
		function! NERDTreeHighlightFile(extension, fg, bg,)
			exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:bg .' guifg='.  a:fg
			exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
		endfunction

		call NERDTreeHighlightFile('md', 'blue', 'none')
		call NERDTreeHighlightFile('ds_store', 'black', 'none')
		call NERDTreeHighlightFile('gitconfig', 'black', 'none')
		call NERDTreeHighlightFile('gitignore', 'gray', 'none')

		"Set cursorline in normal mode
		set cursorline
		autocmd InsertEnter * set nocursorline
		autocmd InsertLeave * set cursorline
		autocmd BufEnter * set cursorline
		autocmd BufLeave * set nocursorline
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	" }}}
	" FZF {{{
		map  <leader>ff :FZF<CR>
		map  <leader>fg :Ag<CR>

		vmap <leader>fw "my:Ag <C-r>m<CR>
		nmap <leader>fw :Ag <C-r><C-w><CR>

		map  <leader>ah :History<CR>
		tmap <leader>fh <c-\><c-n>:History<CR>

		map  <leader>fl :Lines<CR>
	" }}}
	" Other {{{
		let g:airline_mode_map = { '__' : '-', 'n'  : 'N', 'i'  : 'I', 'R'  : 'R', 'c'  : 'C', 'v'  : 'V', 'V'  : 'V', '' : 'V', 's'  : 'S', 'S'  : 'S', '' : 'S', }
	" }}}
" }}}
