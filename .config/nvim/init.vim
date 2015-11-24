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
		  NeoBundle 'kien/ctrlp.vim'

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
	set background=dark
	colorscheme solarized
	let g:airline_powerline_fonts = 1
" }}}
" Key bindings {{{
	let mapleader = ','
	nnoremap <space> za
	inoremap hj <esc>
	vnoremap hj <esc>
	" Remaps {{{
		vnoremap > >gv
		vnoremap < <gv
		nnoremap Q <nop>
		nnoremap , za
	" Remaps }}}
" Key bindings }}}
" Autocmds {{{
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevel=0
" }}}
" NERDTree {{{
	map <C-\> :NERDTreeToggle<CR>
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	let NERDTreeShowHidden=1

	" NERDTress File highlighting
	function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
		exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='.  a:guifg
		exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
	endfunction

	call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
	call NERDTreeHighlightFile('md', 'blue', 'none', '#6699CC', 'none')
	call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
	call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
	call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
	call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
	call NERDTreeHighlightFile('css', 'cyan', 'none', '#5486C0', 'none')
	call NERDTreeHighlightFile('scss', 'cyan', 'none', '#5486C0', 'none')
	call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
	call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
	call NERDTreeHighlightFile('ts', 'Blue', 'none', '#6699cc', 'none')
	call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'none')
	call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
	call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#7F7F7F', 'none')
" }}}
