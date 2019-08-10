" ==============================================================================
"  	 FILE:	.vimrc
"  AUTHOR:	Matthew Ellis
"    DATE:	2019-07-02
" ==============================================================================

" Plug in part from:
" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" version: 8.3.1

" ==============================================================================
" VIM-PLUG INITIALIZATION
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ==============================================================================
" ACTIVE PLUGINS
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Override configs by directory
"Plug 'arielrossanigo/dir-configs-override.vim'
" Better file browser
Plug 'scrooloose/nerdtree'
" Using tabs
"Plug 'jistr/vim-nerdtree-tabs'
" Code commenter
"Plug 'scrooloose/nerdcommenter'
" Class/module browser
"Plug 'majutsushi/tagbar'
" Code and files fuzzy finder
"Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
"Plug 'fisadev/vim-ctrlp-cmdpalette'
" Zen coding
"Plug 'mattn/emmet-vim'
" Git integration
"Plug 'motemen/git-vim'
" Tab list panel
"Plug 'kien/tabman.vim'
" Airline
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
" Terminal Vim with 256 colors colorscheme
"Plug 'fisadev/fisa-vim-colorscheme'
" Consoles as buffers
"Plug 'rosenfeld/conque-term'
" Pending tasks list
"Plug 'fisadev/FixedTaskList.vim'
" Surround
"Plug 'tpope/vim-surround'
" Autoclose
"Plug 'Townk/vim-autoclose'
" Indent text object
"Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
"Plug 'jeetsukumaran/vim-indentwise'
" Better autocompletion
"Plug 'Shougo/neocomplcache.vim'
" Snippets manager (SnipMate), dependencies, and snippets repo
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'honza/vim-snippets'
"Plug 'garbas/vim-snipmate'
" Git/mercurial/others diff icons on the side of the file lines
"Plug 'mhinz/vim-signify'
" Automatically sort python imports
"Plug 'fisadev/vim-isort'
" Drag visual blocks arround
"Plug 'fisadev/dragvisuals.vim'
" Window chooser
"Plug 't9md/vim-choosewin'
" Python and other languages code checker
"Plug 'scrooloose/syntastic'
" Paint css colors with the real color
"Plug 'lilydjwg/colorizer'
" Ack code search (requires ack installed in the system)
"Plug 'mileszs/ack.vim'
"if has('python')
    " YAPF formatter for Python
    "Plug 'pignacio/vim-yapf-format'
"endif
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
" Plug 'myusuf3/numbers.vim'

" Python plug-ins
" Indenting to conform to PEP8
"Plug 'vim-scripts/indentpython.vim'
" Autocomplete
Plug 'Valloric/YouCompleteMe'
" Powerline
"Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}


" Plugins from vim-scripts repos:

" Search results counter
"Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
"Plug 'vim-scripts/matchit.zip'
" Gvim colorscheme
"Plug 'vim-scripts/Wombat'
" Yank history navigation
"Plug 'vim-scripts/YankRing.vim'

" For (Python) development:

" Python autocompletion, go to definition.
"Plug 'davidhalter/jedi-vim'
"Plug 'Valloric/YouCompleteMe'
" PEP8 checking
"Plug 'nvie/vim-flake8'
" Better file browser
"Plug 'scrooloose/nerdtree'
" Using tabs
Plug 'jistr/vim-nerdtree-tabs'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plug 'ctrlpvim/ctrlp.vim'
" Powerline
Plug 'powerline/powerline'
" Python Mode
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" Vim-LaTeX
Plug 'vim-latex/vim-latex'
" Language-tool
Plug 'rhysd/vim-grammarous'


" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ==============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
set rtp+=~/.vim/plugged/powerline/powerline/bindings/vim

" ==============================================================================
" GENERAL CONFIGURATION

" Use UTF-8 encoding
set encoding=utf-8

" Use Vim settings, rather than Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set the clipboard to use system clipboard
set clipboard=unnamed

" Leader key
let mapleader="\\"

" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
filetype  plugin on
filetype  indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" line numbering
set number

" incremental search
set incsearch

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" TAB
set tabstop=4					" Number of spaces that a <Tab> counts for
set softtabstop=4
set shiftwidth=4				" Number of spaces to use for each step of indent
set smartindent					" Smart autoindenting when starting a new line
"set noexpandtab					" Do not expand a tab to spaces
set expandtab					" expand tabs
set autoindent					" copy indent from current line

" Enable the mouse
if has('mouse')
	set mouse=a
endif

" Add .m suffixes when searching for files
set suffixesadd+=.m

" Setup environment
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files for tab complete
set wildmenu

" Case insensitive while searching for files
set wildignorecase

 " Build ignores
set wildignore+=*.pyc
set wildignore+=*_build_/*
set wildignore+=*/coverage/*
set wildignore+=venv/*

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest:full,full

" Paste Toggle
set pastetoggle=<F2>

" Code folding
"set foldmethod=indent
"
" Keep all folds open when a file is opened
" augroup OpenAllFoldsOnFileOpen
"	autocmd!
"	autocmd BufRead * normal zR
" augroup END

" ==============================================================================
" COLORS

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
"colorscheme darkblue
color wombat256mod

" Highlight end of column
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Deal with the colors in vimdiff
if &diff
	colorscheme evening
endif

"if has('unix')
"	highlight Normal ctermbg=none
"	highlight NonText ctermbg=none
"endif

" ==============================================================================
" COMMANDS

" TAG jumping
command! MakeTags !ctags -R --exclude=.git --exclude=venv .

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Mark extra whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Gets rid of extra space
autocmd BufWritePre * %s/\s\+$//e

" Tab length exceptions on some file types
"autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
"autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
"autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" ==============================================================================
" KEY MAPPINGS

" Remap esc
imap qq <Esc>

" Remap for closing buffers
"nnoremap <leader>q :bp<cr>:bd #<cr>

"" Remap keys for buffer switching
"map <F2> :bprevious<CR>
"map <F3> :bnext<CR>

" Tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>
" Easier moving between tabs
"map <Leader>n <esc>:tabprevious<CR>
"map <Leader>m <esc>:tabnext<CR>

" Quick saving
map <C-s> <ESC>:w<CR>
imap <C-s> <ESC>:w<CR>jj
" navigate windows with meta+arrows
"map <M-Right> <c-w>l
"map <M-Left> <c-w>h
"map <M-Up> <c-w>k
"map <M-Down> <c-w>j
"imap <M-Right> <ESC><c-w>l
"imap <M-Left> <ESC><c-w>h
"imap <M-Up> <ESC><c-w>k
"imap <M-Down> <ESC><c-w>j

" old autocomplete keyboard shortcut
"imap <C-J> <C-X><C-O>

" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" ==============================================================================
" BACK-UPS

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" ==============================================================================
" PLUG-INS

" Nerdtree ------------------------------

" Automatically open NerdList on vim open and move cursor to first buffer
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

"" Move nerdtree to the right
"let g:NERDTreeWinPos = "right"
"" " move to the first buffer
"autocmd VimEnter * wincmd p

" Powerline ------------------------------

let g:powerline_pycmd='py3'
set laststatus=2

" Python-mode ------------------------------

" Map sort function to a key
vnoremap <Leader>s :sort<CR>

" Code folding
let g:pymode_folding = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_python = 'python3'
" map <Leader>g :call RopeGotoDefinition()<CR>
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = vnew
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" let g:pymode_rope_lookup_project = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Vim-Latex ------------------------------

" Make vim invoke Latex-Suite when you open a tex file - already active
" filetype plugin on
"
"" grep will sometimes skip displaying the file name if you search in a single
"" file. This will confuse Latex-Suite. Set your grep program to always
"" generate a file-name
"set grepprg=grep\ -nH\ $*

" Enable automatic indentation as you type
"TODO: only enable for tex files
"autocmd filetype latex indent on
autocmd BufNewFile,BufRead *.tex,*.md set spell
autocmd BufNewFile,BufRead *.tex,*.md set wrap
autocmd BufNewFile,BufRead *.tex,*.md set linebreak

" Starting with Vim 4, the filetype of empty .tex files defaults to 'plaintex'
" instead of 'tex', which results in vim-latex not being loaded. The following
" changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"" Just a little bit of indentation
""set sw=2
"
" label: \label{fig:something}, then if you type in \ref{fig: and press <C-n>
" you will automatically cycle through all the figure labels.
set iskeyword+=:

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode -file-line-error-style $*'
if has('win32unix')
	let g:Tex_ViewRule_pdf = 'C:/Users/cellism7/AppData/Local/Apps/Evince-2.32.0.145/bin/evince.exe'
elseif has('unix')
	let g:Tex_ViewRule_pdf = 'evince'
endif
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'

"autocmd BufEnter *.tex filetype plugin on|set shellslash| set grepprg=grep\ -nH\ $*|filetype indent on|let g:tex_flavor='latex'|set iskeyword+=:

" Jedi-vim ------------------------------

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"set completeopt=longest,menuone
"function! OmniPopup(action)
"  if pumvisible()
"    if a:action == 'j'
"      return "\<C-N>"
"    elseif a:action == 'k'
"      return "\<C-P>"
"    endif
"  endif
"  return a:action
"endfunction
"
"inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" All these mappings work only for python code:
" Go to definition
"let g:jedi#goto_command = ',d'
""" Find ocurrences
"let g:jedi#usages_command = ',o'
""" Find assignments
"let g:jedi#goto_assignments_command = ',a'
""" Go to definition in new tab
"nmap ,D :tab split<CR>:call jedi#goto()<CR>

" YouCompleteMe ------------------------------

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
"set completeopt-=preview

let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" ==============================================================================
" PYTHON SUPPORT

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

" ==============================================================================
" FUNCTIONS

" Matlab template - need to update
function! s:insert_m_file_header()
	"let gatename = subtitute(toupper(expand("%:t")), "\\.", "_", "g")
	let fname = substitute(expand("%.t"), "\\.m", "", "g")
	let commname = toupper(fname)
	execute "normal! iclassdef " . fname . " < handle"
	execute "normal! o%" . commname . " "
	execute "normal! o%  "
	execute "normal! o"
	execute "normal! o% Author:			Matthew Ellis"
	execute "normal! o% Date:				" . strftime("%Y-%m-%d")
	execute "normal! o% Revisions:"
	execute "normal! o%   1.0." . strftime("%Y%m%d") . "	Original version"
	execute "normal! o%"
	execute "normal! o% © " . strftime("%Y") . ". University of California, Davis. All rights reserved."
	execute "normal! o"
	execute "normal! o	properties"
	execute "normal! oend"
	execute "normal! o"
	execute "normal! o	methods"
	execute "normal! o	function obj = " . fname . "( argin )"
	execute "normal! oend % " . fname
	execute "normal! o\<esc>xi	end"
	execute "normal! o\<esc>xiend % " . fname
	normal! gg
endfunction
autocmd BufNewFile *.{m} call <SID>insert_m_file_header()

" Close NERDTree if there is no active buffer
function! NERDTreeQuit()
	redir => buffersoutput
	silent buffers
	redir END
"                     1BufNo  2Mods.     3File           4LineNo
	let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
	let windowfound = 0

	for bline in split(buffersoutput, "\n")
		let m = matchlist(bline, pattern)

		if (len(m) > 0)
			if (m[2] =~ '..a..')
				let windowfound = 1
			endif
		endif
	endfor

	if (!windowfound)
		quitall
	endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

"function! SetupEnvironment()
"	let l:path = expand( '%:p' )
"	if l:path =~ '/cygdrive/d/MatlabKernels'
"		let &path.="/cygdrive/d/MatlabKernels/**"
"	endif
"endfunction
"autocmd! BufReadPost,BufNewFile * call SetupEnvironment()

" EOF
