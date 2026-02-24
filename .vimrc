" ==============================================================================
"  	 FILE:	.vimrc
"  AUTHOR:	Matthew Ellis
" ==============================================================================

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
" Autocomplete
Plug 'Valloric/YouCompleteMe'
" PEP8 checking
Plug 'nvie/vim-flake8'
" Better file browser
Plug 'scrooloose/nerdtree'
" Using tabs
Plug 'jistr/vim-nerdtree-tabs'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plug 'ctrlpvim/ctrlp.vim'
" Powerline
Plug 'powerline/powerline'
" Python Mode
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'python-rope/ropevim'
" Python imports
Plug 'mgedmin/python-imports.vim'
" Vim-LaTeX
Plug 'vim-latex/vim-latex'
" Language-tool
Plug 'rhysd/vim-grammarous'
" Vim-Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Color scheme
Plug 'KyleOndy/wombat256mod'
" Character diff
Plug 'rickhowe/diffchar.vim'
" Vim-tables
Plug 'dhruvasagar/vim-table-mode'
" CSV files
Plug 'chrisbra/csv.vim'

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

" Be able to use shell aliases in vim
let $BASH_ENV = "~/.config/shell/aliases"

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
set noexpandtab					" Do no expand tabs
set autoindent					" copy indent from current line

" Expand tabs for Python
autocmd FileType py setlocal expandtab

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

" ==============================================================================
" COLORS

" Color scheme
set t_Co=256
color wombat256mod

" Highlight end of column
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Deal with the colors in vimdiff
if &diff
	colorscheme evening
endif

" ==============================================================================
" COMMANDS

" TAG jumping
command! MakeTags !ctags -R --exclude=.git --exclude=*venv* .

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Mark extra whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Gets rid of extra space
autocmd BufWritePre * %s/\s\+$//e

" ==============================================================================
" KEY MAPPINGS

" Remap esc
imap qq <Esc>

"" Remap keys for buffer switching
map <F2> :bprevious<CR>
map <F3> :bnext<CR>

" Tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm<space>
map tt :tabnew<space>
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>
" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
" Open tag in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" Quick saving
map <C-s> <ESC>:w<CR>
imap <C-s> <ESC>:w<CR>jj

"" Copy and paste to system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

" Close location lists and quick fix windows
autocmd FileType python nmap <Leader>c <c-w>z :windo lcl\|ccl<CR>

" VISUAL MODE
" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" Exit visual mode
vnoremap qq <esc>

nnoremap <Leader>t  :GetTemplate<Space>

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

" Grammarous -----------------------------

let g:grammarous#move_to_first_error = 0
let g:grammarous#show_first_error = 1
nmap <Leader>g <Plug>(grammarous-open-info-window)


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
" let g:pymode_folding = 0
" let g:pymode_rope_complete_on_dot = 0
let g:pymode_python = 'python3'
let g:pymode_virtualenv = 1
" map <Leader>g :call RopeGotoDefinition()<CR>
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = vnew
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" let g:pymode_rope_lookup_project = 0
let python_highlight_string_format = 1
let python_highlight_doctests = 0

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
let g:Tex_CompileRule_pdf = 'latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error $*'
" Search in vim <Leader>ls
let g:Tex_BackwardSearch = 'vim --servername vim --remote +%l %f'
let g:Tex_ViewRule_pdf = 'zathura --synctex-editor-command="vim --servername {v:servername} --remote +\%{line} \%{input}"'
let g:Tex_ViewRuleComplete_pdf = 'zathura --synctex-editor-command="vim --servername {v:servername} --remote +\%{line} \%{input}" '.shellescape(expand("%:p:r")).'.pdf > /dev/null 2>&1 &'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'

map <C-Enter> :call Tex_

"autocmd BufEnter *.tex filetype plugin on|set shellslash| set grepprg=grep\ -nH\ $*|filetype indent on|let g:tex_flavor='latex'|set iskeyword+=:
let g:Tex_IgnoreLevel=0

" Prevent vim-latex from going to an error after successful complilation
let g:Tex_GotoError = 0

" Markdown ------------------------------
autocmd FileType markdown noremap <Leader>c i::: {.columns}<CR>:::: {.column width=<++>%}<CR><CR><++><CR><CR>::::<CR>:::: {.column width=<++>%}<CR><CR><++><CR><CR>::::<CR>:::<Esc>11k2h
autocmd FileType markdown noremap <Leader>lv :!xdg-open %:r.pdf &<CR><CR>
noremap <Leader>w :w<CR>
autocmd FileType markdown noremap <Leader>w :w<CR>:make<CR>

" YouCompleteMe ------------------------------

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
"set completeopt-=preview

let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Vim-pandoc ------------------------------
let g:pandoc#folding#level = 8

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
"autocmd WinEnter * call NERDTreeQuit()
"
" function! CheckLeftBuffers()
" 	if tabpagenr('$') == 1
" 		let i = 1
" 		while i <= winnr('$')
" 			if getbufvar(winbufnr(i), '&buftype') == 'help' ||
" 				\ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
" 				\ exists('t:NERDTreeBufName') &&
" 				\   bufname(winbufnr(i)) == t:NERDTreeBufName ||
" 				\ bufname(winbufnr(i)) == '__Tag_List__' ||
" 				\ bufname(winbufnr(i)) == '[Location List]'
" 				let i += 1
" 			else
" 				break
" 			endif
" 		endwhile
" 		if i == winnr('$') + 1
" 			qall
" 		endif
" 		unlet i
" 	endif
" endfunction
" autocmd BufEnter * call CheckLeftBuffers()

function GetTemplate(fname)
	let fpath = findfile(a:fname, expand('$HOME/Templates').'/**')
	execute '-1read ' . fpath
	call feedkeys("\<C-j>")
endfunction
command! -nargs=1 GetTemplate call GetTemplate(<q-args>)

" EOF
