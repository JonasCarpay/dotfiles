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
		  NeoBundle 'albfan/nerdtree-git-plugin'
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
		  NeoBundle 'kassio/neoterm'

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
	syntax manual
	set number
	set wrap nolist linebreak breakindent
	set incsearch hlsearch ignorecase smartcase
	set expandtab tabstop=4 shiftwidth=4
	set background=dark
	let g:tex_flavor = "latex"
	colorscheme solarized
	let g:airline_powerline_fonts = 1
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" }}}
" Key bindings {{{
	let mapleader = "\<space>"
	ino hj <esc>
	vn hj <esc>
	ino HJ <esc>
	ino Hj <esc>

	nn <Leader>ch :nohl<CR>
	nn <Leader>w :wa<CR>
	nn <Leader>vs <C-w>v<C-w>l
	nn <Leader>hs <C-w>s<C-w>j
	nn <Leader>n :NERDTreeToggle<CR>
	nn <Leader>m :T make<CR>
	nn <C-s> :if &syntax=="on" <Bar> set syntax=off <Bar> else <Bar> set syntax=on <Bar> endif<CR>

	" Git/gutter/fugitive
	nn <Leader>gt :GitGutterToggle<CR>
	nn <Leader>gs :Gstatus<CR>
	nn <Leader>gc :Gcommit<CR>
	nn <Leader>gd :Gdiff<CR>

	" Easy-align
	vmap <Enter> <Plug>(LiveEasyAlign)

	" Ultisnips
	let g:UltiSnipsExpandTrigger="<c-c>"
	let g:UltiSnipsJumpForwardTrigger="<c-b>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"

	" Neoterm
	tnoremap hj <C-\><C-n>

	" Remaps {{{
		vn > >gv
		vn < <gv
		nn Q <nop>
		nn , za
		nn j gj
		nn k gk
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
