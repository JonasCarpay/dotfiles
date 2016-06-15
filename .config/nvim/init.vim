" Neovim configuration

" Vim-plug  {{{
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
		  Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
		  Plug 'junegunn/fzf.vim'

		" Syntax and highlighting
		  Plug 'altercation/vim-colors-solarized'
		  Plug 'fcpg/vim-fahrenheit'
		  Plug 'scrooloose/nerdcommenter'
		  Plug 'benekastah/neomake'
		  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
			  let g:deoplete#enable_at_startup = 1
			  let g:deoplete#enable_camel_case = 1
			  let g:deoplete#max_abbr_width=0
			  let g:deoplete#max_menu_width=0
			  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
			  function! s:my_cr_function() abort
				  return deoplete#mappings#close_popup() . "\<CR>"
			  endfunction
		  Plug 'ntpeters/vim-better-whitespace'

		" Editing
		  Plug 'tpope/vim-surround'
		  Plug 'Lokaltog/vim-easymotion'
		  Plug 'junegunn/vim-easy-align'
		  Plug 'SirVer/ultisnips'
			  let g:UltiSnipsUsePythonVersion = 2
		  Plug 'honza/vim-snippets'
		  Plug 'tpope/vim-sleuth'
		  Plug 'michaeljsmith/vim-indent-object'
		  Plug 'ervandew/supertab'
			  let g:SuperTabDefaultCompletionType="<c-n>"

		" Language-specific
		  Plug 'neovimhaskell/haskell-vim'
		  Plug 'eagletmt/ghcmod-vim'
		  let g:ghcmod_ghc_options = ['-idir1', '-idir2']
		  Plug 'eagletmt/neco-ghc'
		  let g:necoghc_enable_detailed_browse = 1
		  Plug 'mattn/emmet-vim'
		  Plug 'Slava/vim-spacebars'

		" Other
		  Plug 'vim-airline/vim-airline'
		  Plug 'vim-airline/vim-airline-themes'
		  Plug 'jeetsukumaran/vim-indentwise'
		  Plug 'jeetsukumaran/vim-buffergator'
		  Plug 'kassio/neoterm'

	call plug#end()
" NeoBundle }}}
" System settings {{{
	syntax enable
	set syntax=on
	set number
	set wrap nolist linebreak breakindent
	set incsearch hlsearch ignorecase smartcase
	set expandtab tabstop=4 shiftwidth=4
	set background=dark
	let g:tex_flavor = "latex"
	colorscheme solarized
	colorscheme fahrenheit
	let g:airline_powerline_fonts = 1
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


	let g:haskellmode_completion_ghc = 0
	autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" }}}
" Key bindings {{{
	let mapleader = "\<space>"
	ino hj <esc>
	ino HJ <esc>
	ino Hj <esc>
	ino jh <esc>
	ino JH <esc>
	ino Jh <esc>
	imap jj <CR>

	nn <Leader>ch :nohl<CR>
	nn <Leader>w :wa<CR>
	nn <Leader>n :NERDTreeToggle<CR>
	nn <Leader>m :T make<CR>
	nn <C-s> :if &syntax=="on" <Bar> set syntax=off <Bar> else <Bar> set syntax=on <Bar> endif<CR>
	vnoremap @ :norm@

	" Git/gutter/fugitive
	nn <Leader>gt :GitGutterToggle<CR>
	nn <Leader>gs :Gstatus<CR>
	nn <Leader>gc :Gcommit<CR>
	nn <Leader>gd :Gdiff<CR>

	" Language-specific
	"" Haskell
	autocmd FileType haskell ino >> <space>-><space>
	autocmd FileType haskell ino +> <space>=><space>
	autocmd FileType haskell ino << <space><-<space>
	autocmd FileType haskell ino >+ <space>>>=<space>
	autocmd FileType haskell ino >>> <space>>><space>
	autocmd FileType haskell ino $$ <space><$><space>
	autocmd FileType haskell ino ** <space><*><space>
	autocmd FileType haskell nn <Leader>hi :GhcModTypeInsert<CR>
	autocmd FileType haskell nn <Leader>ht :GhcModType<CR>
	autocmd FileType haskell nn <Leader>hc :GhcModTypeClear<CR>
	autocmd FileType haskell nn <Leader>hs :GhcModSplitFunCase<CR>

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
	autocmd FileType * set syntax=on " To allow syntax highlighting toggling
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
	" Haskell {{{
		let g:haskell_enable_quantification = 1
		let g:haskell_enable_quantification = 1
		let g:haskell_enable_recursivedo = 1
		let g:haskell_enable_arrowsyntax = 1
		let g:haskell_enable_pattern_synonyms = 1
		let g:haskell_enable_typeroles = 1
		let g:haskell_enable_static_pointers = 1
		let g:haskell_indent_if = 3
		let g:haskell_indent_case = 2
		let g:haskell_indent_let = 4
		let g:haskell_indent_where = 6
		let g:haskell_indent_do = 3
		let g:haskell_indent_in = 1
		let g:haskell_indent_guard = 2
		let g:cabal_indent_section = 2
	" }}}
" }}}
