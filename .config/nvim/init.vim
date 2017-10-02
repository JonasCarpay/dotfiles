let mapleader = "\<space>"

" Vim-plug	{{{
	call plug#begin('~/.config/nvim/plugged')
		function! DoRemote(arg)
			UpdateRemotePlugins
		endfunction
		" Helpers
			Plug 'tpope/vim-repeat'
			Plug 'Shougo/vimproc.vim', {'do': 'make'}

		" Git helpers
			Plug 'tpope/vim-fugitive'
			Plug 'airblade/vim-gitgutter'

		" File navigation
			Plug 'tpope/vim-eunuch'
			Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
			Plug 'junegunn/fzf.vim'

		" Syntax and highlighting
			Plug 'fcpg/vim-fahrenheit'
      Plug 'neomake/neomake'
        " Neomake cfg {{{
          autocmd! BufWritePost * Neomake
          nn <leader>n :Neomake<CR>
          let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']
        " }}}
			Plug 'scrooloose/nerdcommenter'
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
      Plug 'sheerun/vim-polyglot'

		" Editing
			Plug 'tpope/vim-unimpaired'
			Plug 'tpope/vim-surround'
			Plug 'Lokaltog/vim-easymotion'
			Plug 'junegunn/vim-easy-align'
			Plug 'SirVer/ultisnips'
				let g:UltiSnipsUsePythonVersion = 2
			Plug 'honza/vim-snippets'
			Plug 'Raimondi/vim_search_objects'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'ervandew/supertab'
        let g:SuperTabDefaultCompletionType = "<c-n>"

		" Language-specific
			" Haskell {{{
				Plug 'eagletmt/ghcmod-vim'
				Plug 'glittershark/vim-hare'
				Plug 'eagletmt/neco-ghc'
        let g:necoghc_enable_detailed_browse = 1
      " }}}
      " Rust {{{
        Plug 'racer-rust/vim-racer'
        set hidden
        let g:racer_cmd = "~/.cargo/bin/racer"
        au FileType rust nmap gd <Plug>(rust-def)
        au FileType rust nmap gs <Plug>(rust-def-split)
        au FileType rust nmap gx <Plug>(rust-def-vertical)
        au FileType rust nmap <leader>gd <Plug>(rust-doc)
        au BufRead *.rs :setlocal tags=./rusty-tags.vi;/
        au BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&"
      " }}}
      Plug 'rbonvall/snipmate-snippets-bib'
      Plug 'Harenome/vim-mipssyntax'
      "Plug 'OmniSharp/omnisharp-vim'

		" Other
			Plug 'vim-airline/vim-airline'
			Plug 'jeetsukumaran/vim-indentwise'
			Plug 'rizzatti/dash.vim'

	call plug#end()
  " }}}
" System settings {{{
	syntax enable
  set mouse=a
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
  " Cursorline {{{
    set cursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
    autocmd BufEnter * set cursorline
    autocmd BufLeave * set nocursorline
    " }}}
  " }}}
" Key bindings {{{
	" Remaps
    nmap H [-
    nmap L ]+
    nmap J ]=
    nmap K [=
    nn M J
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
	nn <Leader>l :lopen<CR>
	autocmd FileType haskell nn <Leader>ch :nohl<CR>:GhcModTypeClear<CR>
	nn <Leader>yy mmggVG"*y'm
	nn <Leader>yp :set paste<CR>"*p:set nopaste<CR>
	nn <Leader>w :wa<CR>
	nn <C-s> :if &syntax=="on" <Bar> set syntax=off <Bar> else <Bar> set syntax=on <Bar> endif<CR>
	vnoremap @ :norm@

  inoremap <A-[> {<CR>}<esc>O

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
		map	<leader>ff :Files<CR>
		map	<leader>fg :Ag<CR>
		map	<leader>fw :Ag <C-R><C-W><CR>
		map	<leader>ft :Tags<CR>
		map	<leader>fh :Helptags<CR>

		map	<leader>ah :History<CR>
		tmap <leader>fh <c-\><c-n>:History<CR>

		map	<leader>fl :Lines<CR>

  " }}}
  " Language config {{{
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
		let g:airline_mode_map = { '__' : '-', 'n'	: 'N', 'i'	: 'I', 'R'	: 'R', 'c'	: 'C', 'v'	: 'V', 'V'	: 'V', '' : 'V', 's'	: 'S', 'S'	: 'S', '' : 'S', }
  " }}}

" vim:fdm=marker:foldopen=all:foldclose=all
