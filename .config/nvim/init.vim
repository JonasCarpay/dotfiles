" Neovim configuration

" Vim-plug	{{{
	call plug#begin('~/.config/nvim/plugged')
		function! DoRemote(arg)
			UpdateRemotePlugins
		endfunction
		" Helpers
			Plug 'tpope/vim-unimpaired'
			Plug 'tpope/vim-repeat'
			Plug 'Shougo/vimproc.vim', {'do': 'make'}

		" Git helpers
			Plug 'tpope/vim-fugitive'
			Plug 'airblade/vim-gitgutter'

		" File navigation
			Plug 'scrooloose/nerdtree'
			Plug 'albfan/nerdtree-git-plugin'
			Plug 'ryanoasis/vim-devicons'
			Plug 'tpope/vim-eunuch'
			Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
			Plug 'junegunn/fzf.vim'

		" Syntax and highlighting
			Plug 'altercation/vim-colors-solarized'
			Plug 'fcpg/vim-fahrenheit'
			Plug 'rakr/vim-one'
			Plug 'scrooloose/nerdcommenter'
			Plug 'neomake/neomake'
				" Neomake cfg {{{
						autocmd! BufWritePost * Neomake
						let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']
				" }}}
			Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
				" Deoplete cfg {{{
						let g:deoplete#enable_at_startup = 1
						let g:deoplete#enable_camel_case = 1
						let g:deoplete#max_abbr_width=0
						let g:deoplete#max_menu_width=0
						inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
						function! s:my_cr_function() abort
							return deoplete#mappings#close_popup() . "\<CR>"
						endfunction
				" }}}
			Plug 'ntpeters/vim-better-whitespace'

		" Editing
			Plug 'tpope/vim-surround'
			Plug 'Lokaltog/vim-easymotion'
			Plug 'junegunn/vim-easy-align'
			Plug 'SirVer/ultisnips'
				let g:UltiSnipsUsePythonVersion = 2
			Plug 'honza/vim-snippets'
			Plug 'Raimondi/vim_search_objects'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'ervandew/supertab'
				let g:SuperTabDefaultCompletionType="<c-n>"

		" Language-specific
			" Haskell
				Plug 'neovimhaskell/haskell-vim'
				Plug 'glittershark/vim-hare'
				Plug 'eagletmt/ghcmod-vim'
				Plug 'eagletmt/neco-ghc'
          let g:necoghc_enable_detailed_browse = 1
			Plug 'mattn/emmet-vim'
			Plug 'Slava/vim-spacebars'
      Plug 'rust-lang/rust.vim'
      Plug 'Harenome/vim-mipssyntax'

		" Other
			Plug 'vim-airline/vim-airline'
			Plug 'vim-airline/vim-airline-themes'
			Plug 'jeetsukumaran/vim-indentwise'
			Plug 'kassio/neoterm'
			Plug 'rizzatti/dash.vim'
			Plug 'tyru/open-browser.vim'

	call plug#end()
" NeoBundle }}}
" System settings {{{
	syntax enable
	set syntax=on
	set number
  set scrolloff=3
  set termguicolors
	colorscheme fahrenheit
	set wrap nolist linebreak breakindent
  set inccommand=nosplit
  set indentkeys-=<space>
	set incsearch hlsearch ignorecase smartcase
	set expandtab tabstop=2 shiftwidth=2
	set background=dark
	let g:tex_flavor = "latex"
	let g:airline_powerline_fonts = 1
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
	set splitright
  autocmd FileType * set syntax=on " To allow syntax highlighting toggling

" }}}
" Key bindings {{{
	let mapleader = "\<space>"

	" Remaps
		vn > >gv
		vn < <gv
		nn Q :normal @q<CR>
		nn , za
		nn j gj
		nn k gk

	" Exiting
		ino hj <esc>
		ino Hj <esc>
		vn  hj <esc>

	nn <C-j> <C-w>}
	nn <Leader>op :vnew<CR>:set pvw<CR><C-w>20<<C-w>h
	nn <Leader>ch :nohl<CR>
	autocmd FileType haskell nn <Leader>ch :nohl<CR>:GhcModTypeClear<CR>
	nn <Leader>yy mmggVG"*y'm
	nn <Leader>yp :set paste<CR>"*p:set nopaste<CR>
	nn <Leader>w :wa<CR>
	nn <Leader>n :NERDTreeToggle<CR>
	nn <Leader>m :T make<CR>
	nn <C-s> :if &syntax=="on" <Bar> set syntax=off <Bar> else <Bar> set syntax=on <Bar> endif<CR>
	vnoremap @ :norm@

  function! GithubSearch()
    let termRaw   = getreg("9")
    let termClean = " " . substitute(termRaw, "[^a-zA-Z0-9 ]", " ", "g")
    let term      = substitute(termClean, "\s\+", " ", "g")
    let termEsc   = substitute(term, " ", "+", "g")
    let prefix    = "https://github.com/search?&type=Code&q=language:"
    let url       = prefix . &ft . termEsc
    exec openbrowser#open(url)
  endfunction
  vn <leader>gh "9y:call GithubSearch()<CR>
  nn <leader>gh viw"9y:call GithubSearch()<CR>


	" Dash-vim
	nn <leader>d :Dash<CR>

	" Git/gutter/fugitive
	nn <Leader>gt :GitGutterToggle<CR>
	nn <Leader>ga :GitGutterStageHunk<CR>
	nn <Leader>gA :GitGutterUndoHunk<CR>
	nn <Leader>gs :Gstatus<CR>
	nn <Leader>gc :Gcommit<CR>
	nn <Leader>gd :Gdiff<CR>

	" Easy-align
	vmap <Enter> <Plug>(LiveEasyAlign)

	" Ultisnips
	let g:UltiSnipsExpandTrigger="<c-c>"
	let g:UltiSnipsJumpForwardTrigger="<c-s>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"

	" FZF
		let g:fzf_tags_command = 'hasktags -xc .'
		map	<leader>ff :Files<CR>
		map	<leader>fg :Ag<CR>
		map	<leader>fw :Ag <C-R><C-W><CR>
		map	<leader>ft :Tags<CR>
		map	<leader>fh :Helptags<CR>

		map	<leader>ah :History<CR>
		tmap <leader>fh <c-\><c-n>:History<CR>

		map	<leader>fl :Lines<CR>

" Key bindings }}}
  " Language config {{{
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    let g:haskellmode_completion_ghc = 0
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType haskell set formatprg=pointfree\ --stdin
    "autocmd FileType haskell ino >>	<space>-><space>
    "autocmd FileType haskell ino +>	<space>=><space>
    "autocmd FileType haskell ino <<	<space><-<space>
    "autocmd FileType haskell ino >+	<space>>>=<space>
    "autocmd FileType haskell ino >>> <space>>><space>
    "autocmd FileType haskell ino $$	<space><$><space>
    "autocmd FileType haskell ino ::	<space>::<space>
    "autocmd FileType haskell ino **	<space><*><space>
    autocmd FileType haskell nn <Leader>ht :GhcModTypeInsert<CR>
    autocmd FileType haskell nn <Leader>hq :GhcModType<CR>
    autocmd FileType haskell nn <Leader>hs :!stack test<CR>
    autocmd FileType haskell nn <Leader>hc :GhcModCheck<CR>
    autocmd FileType haskell nn <Leader>hr :Hrename 
    autocmd FileType haskell nn <Leader>hi :HsimportSymbol<CR>
    autocmd FileType haskell nn <Leader>hm :HsimportModule<CR>
    autocmd! BufWritePost *.hs :silent execute "!rm tags && hasktags -xc ."
  " }}}
" Plugin-specific {{{
	" NERDTree {{{
		autocmd StdinReadPre * let s:std_in=1
		let NERDTreeShowHidden=1
		let NERDTreeQuitOnOpen=1

		" NERDTress File highlighting
		function! NERDTreeHighlightFile(extension, fg, bg,)
			exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:bg .' guifg='.	a:fg
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
	" Other {{{
		let g:airline_mode_map = { '__' : '-', 'n'	: 'N', 'i'	: 'I', 'R'	: 'R', 'c'	: 'C', 'v'	: 'V', 'V'	: 'V', '' : 'V', 's'	: 'S', 'S'	: 'S', '' : 'S', }
	" }}}
" }}}
