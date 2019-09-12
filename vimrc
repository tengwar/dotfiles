"# My custom .vimrc file - ggrzybow #

set nocompatible " this is just to be safe; having a user .vimrc implies nocompatible
                 " (not set if e.g. it's a system-wide .vimrc or you load it like 'vim -u my_vimrc')

"## Plugins ##
	" 'syntax enable' and 'filetype plugin indent on' must be run after plugins
	" are loaded, so the first section is the plugins one

	" prevent loading Powerline, since we'll use Airline
	let g:powerline_loaded = 1

	" Deoplete (code completion)
	let g:deoplete#enable_at_startup = 1

	" Python Mode
	let g:pymode_options = 1
	if has('win32unix')
		let g:pymode_python = 'python3'
	endif

	" Much simpler Rainbow Parentheses by junegunn (rainbow_parentheses_junegunn.vim)
	let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]

	" Rainbow Parentheses Improved by luochen1990 (rainbow)
	let g:rainbow_active = 0
	let g:rainbow_conf = {
	\	'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta'],
	\	'operators': '_,\|+\|-\|*\|\/\|==\|!=\|;_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'cpp': {
	\			'parentheses': [
	\				'start=/(/ end=/)/ fold',
	\				'start=/\[/ end=/\]/ fold',
	\				'start=/{/ end=/}/ fold',
	\				'start=/\(\(\<operator\>\)\@<!<\)\&[a-zA-Z0-9_]\@<=<\ze[^<]/ end=/>/'
	\			],
	\		},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'vim': {
	\			'parentheses': [
	\				'start=/(/ end=/)/',
	\				'start=/\[/ end=/\]/',
	\				'start=/{/ end=/}/ fold',
	\				'start=/(/ end=/)/ containedin=vimFuncBody',
	\				'start=/\[/ end=/\]/ containedin=vimFuncBody',
	\				'start=/{/ end=/}/ fold containedin=vimFuncBody'
	\			],
	\		},
	\		'html': {
	\			'parentheses': [
	\				'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'
	\			],
	\		},
	\		'css': 0,
	\	}
	\}

	" Airline options
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	" Unicode symbols
	if has('macunix')
		"let g:airline_left_sep = '»'
		"let g:airline_left_sep = '▶'
		let g:airline_left_sep = ''
		"let g:airline_right_sep = '«'
		"let g:airline_right_sep = '◀'
		let g:airline_right_sep = ''
		let g:airline_symbols.crypt = '🔒'
		"let g:airline_symbols.linenr = '␊'
		"let g:airline_symbols.linenr = '␤'
		let g:airline_symbols.linenr = '¶'
		"let g:airline_symbols.maxlinenr = '☰'
		"let g:airline_symbols.maxlinenr = ''
		let g:airline_symbols.branch = '⎇'
		let g:airline_symbols.paste = 'ρ'
		"let g:airline_symbols.paste = 'Þ'
		"let g:airline_symbols.paste = '∥'
		let g:airline_symbols.spell = 'Ꞩ'
		let g:airline_symbols.notexists = '∄'
		let g:airline_symbols.whitespace = 'Ξ'
	endif

	" clang_completion plugin's options
	" path to directory where libclang can be found
	"let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
	" sources for user options passed to clang
	"let g:clang_auto_user_options="compile_commands.json, .clang_complete, path"

	" load Pathogen and in turn other plugins (use :Helptags to generate plugin docs)
	runtime bundle/vim-pathogen/autoload/pathogen.vim  " To have it together with plugins in .vim/bundle
	execute pathogen#infect()

	" load matchit.vim that comes with vim if user hasn't installed a newer version
	if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
		runtime! macros/matchit.vim
	endif

"## Neovim ##
	if has('nvim')
		" Setting this makes startup faster.
		if has('macunix')
			"let g:python_host_prog = '/usr/local/bin/python2'
			let g:python3_host_prog = '/usr/local/bin/python3'
		elseif has('unix')
			let g:python_host_prog = '/usr/bin/python2'
			let g:python3_host_prog = '/usr/bin/python3'
		endif

		set nopaste " Neovim should handle pasting automatically.
	endif

"## Behavior ##
	set encoding=utf-8             " SSH from Windows apparently needs this setting
	set backspace=indent,eol,start " allow deleting these things with backspace
	                               " (start is where the insert mode started)
	set autoread                   " reload the file if it was modified (but not deleted) on disk, but not in Vim
	set nrformats-=octal           " don't treat numbers starting with 0 as octal (affects e.g. CTRL-A)
	set formatoptions+=tcqj        " autowrapping, etc. options; prefer +=/-= over = for future compatibility reasons
	set formatoptions-=v
	set clipboard=                 " if set to "unnamed", vim uses the OS clipboard by default which is annoying;
	                               " that's why we explicitly unset it in case OS-level config enabled it

"## Colors, etc. ##
	if has('win32unix')
		colorscheme default
		let g:airline_solarized_normal_green = 1
		let g:airline_theme='solarized'
		let g:airline_powerline_fonts = 1
	elseif has('macunix')
		set background=light
		colorscheme solarized8_flat
	elseif has('unix')
		set termguicolors " enable 24-bit color support (doesn't work on macOS Terminal.app)
		colorscheme solarized8
		let g:airline_solarized_normal_green = 1
		let g:airline_theme='solarized'
		let g:airline_powerline_fonts = 1
	endif
	syntax enable        " enable syntax processing (syntax on = this + override some color settings)
	set concealcursor=nc " conceal in normal and commandline(?) modes; stop concealing in insert and visual modes
	"set list             " show invisible characters according to the setting below
	set listchars=eol:↵,tab:▸\ ,trail:␠,nbsp:⎵,extends:▶,precedes:◀
	" other possible ideas: → ▸ ↵ ¬ · ␠ ⎵ ↷ ↶ ▶ ◀

"## Spaces & tabs ##
	set autoindent        " keep the current indent level if inserting a newline
	                      " (this may cause problems if pasting multiline text from system clipboard)
	if has('win32unix') || has('macunix')
		set tabstop=2     " use that many spaces to display a tab character
		set shiftwidth=2  " move the code this many columns when (un)indenting
		set expandtab     " insert spaces instead of \t when tab is pressed
		set softtabstop=2 " number of spaces inserted when pressing tab (if <0, the value of shiftwidth is used)
	elseif has('unix')
		set tabstop=4     " use that many spaces to display a tab character
		set shiftwidth=4  " move the code this many columns when (un)indenting
		"set expandtab     " insert spaces instead of \t when tab is pressed
		set softtabstop=4 " number of spaces inserted when pressing tab (if <0, the value of shiftwidth is used)
	endif

"## UI ##
	set title                 " show a custom title on terminal's tab/titlebar
	set number                " show line numbers
	set laststatus=2          " when to show the statusbar; 0=never, 1=with more than 1 window, 2=always
	set ruler                 " show the coords of cursor in the statusbar
	set showcmd               " show the last used command in the bottom right corner
	"set cursorline            " highlight current line
	"set colorcolumn=80,120    " change the background color in the specified columns
	filetype plugin indent on " load filetype-specific indent files [and autocomplete?]
	set wildmenu              " visual autocomplete for command menu
	set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,.~,.svn
	set lazyredraw            " redraw only if you need to, e.g. not in the middle of macros
	"set showmatch             " highlight matching parentheses, etc. (similar functionality is already provided
	"                          " in a different way, so it seems useless)
	set scrolloff=3           " this many lines are visible above/below cursor when scrolling
	set display=lastline      " when the last line doesn't fit, show as much of if as possible with "@@@" at the end
	                          " normally it would replace the whole line with @s

	if &history < 1000
		set history=1000
	endif

	if &tabpagemax < 50
		set tabpagemax=50
	endif


"## Searching ##
	set ignorecase     " make search case-insensitive
	set smartcase      " if (ignorecase && search contains capital letters) => make it case-sensitive
	set incsearch      " search as you type
	set hlsearch       " highlight search matches; use :nohlsearch (or just :nohl) to dehighlight them

"## Folding ##
	"set foldenable        " enable code folding; use 'za' to toggle current fold
	set foldmethod=syntax " folds defined manually by user
	                      " possible values: manual, indent, syntax, expr (less used: marker, diff)
	set foldlevelstart=10 " on start fold blocks indented this many or more levels
	                      " (0 is all folded, 99(?) all unfolded)
	"set foldlevelmax=10   " max number of levels of folds (?)
	set foldnestmax=3     " folds will get nested max this many times

"## Custom functions ##
	" If you add "!" to the "function" keyword, it can be reloaded, but it
	" won't be checked for conflicts.

	" toggle between normal and relative line numbers
	function ToggleLineNumbers()
		if(&relativenumber == 1)
			set norelativenumber
			set number
		else
			set relativenumber
		endif
	endfunc

	" set the width of indents (in spaces)
	function SetIndentWidth(width)
		let &tabstop=a:width
		let &shiftwidth=a:width
		let &softtabstop=a:width
	endfunc

	" switch between using tabs and spaces for indentation (doesn't change existing indents)
	function SwitchIndentMethod()
		set expandtab!
		if(&expandtab)
			echo 'Now using spaces.'
		else
			echo 'Now using tabs.'
		endif
	endfunc

	" select an indent method - width and tabs/spaces
	function SelectIndentMethod(width, type)
		call SetIndentWidth(a:width)
		if(a:type =~ '^tab')
			set noexpandtab
		elseif(a:type =~ '^space')
			set expandtab
		else
			echo 'Wrong type, use either "tab"/"tabs" or "space"/"spaces".'
		endif

		" Restart the Indent Line plugin so the lines match the new indentation
		if exists(":IndentLinesToggle")
			IndentLinesToggle
			IndentLinesToggle
		endif
	endfunc

	" removes all trailing whitespace from the current buffer
	function StripTrailingWhitespace()
		let line = line(".")
		let column = col(".")
		%s/\s\+$//e
		call cursor(line, column)
	endfunc

"## Tweaks ##
	" allow undoing ctrl+u and ctrl+w
	inoremap <c-u> <c-g>u<c-u>
	inoremap <c-w> <c-g>u<c-w>

	" make j & k move by on-screen, not file lines
	nnoremap j gj
	nnoremap k gk
	vnoremap j gj
	vnoremap k gk

	" make :W, :Q, etc. work as :w, :q, etc. (and try to preserve all the options of the original :w)
	command -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
	command -bang Q quit<bang>
	"command WQ wq
	"command Wq wq

	" swap : and ;
	"nnoremap ; :
	"nnoremap : ;
	"vnoremap ; :
	"vnoremap : ;

	" Make space act as '\' (leader).
	"map <Space> <Leader> " This broke The NERD Commenter.
	let mapleader = "\<Space>"

	" make Y yank from cursor to the EOL, not the whole line (more logical, but vi-incompatible)
	noremap Y y$

	" toggle the undo tree from the Gundo plugin
	nnoremap <F5> :GundoToggle<CR>

	" toggle Semantic Highlight
	nnoremap <Leader>s :SemanticHighlightToggle<cr>

	" quickhl.vim bindings
	nmap <Space>m <Plug>(quickhl-manual-this)
	xmap <Space>m <Plug>(quickhl-manual-this)

	nmap <Space>w <Plug>(quickhl-manual-this-whole-word)
	xmap <Space>w <Plug>(quickhl-manual-this-whole-word)

	nmap <Space>c <Plug>(quickhl-manual-clear)
	vmap <Space>c <Plug>(quickhl-manual-clear)

	nmap <Space>M <Plug>(quickhl-manual-reset)
	xmap <Space>M <Plug>(quickhl-manual-reset)

	nmap <Space>j <Plug>(quickhl-cword-toggle)
	nmap <Space>] <Plug>(quickhl-tag-toggle)
	" needs the vim-operator-user plugin
	"map H <Plug>(operator-quickhl-manual-this-motion)


" vim: set noexpandtab ts=4 sw=4 sts=4:
