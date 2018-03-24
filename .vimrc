" ==============================================================================
"  	 FILE:	.vimrc
"  AUTHOR:	Matthew Ellis
" CREATED:	2015-02-28
" ==============================================================================
"
" ------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
" ------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
" ------------------------------------------------------------------------------
" Switch syntax highlighting on.
" ------------------------------------------------------------------------------
syntax    on  
" ------------------------------------------------------------------------------
"set backupdir=$HOME/.vimbackup						" Back-up directory
set dictionary=/usr/share/dict/words 				" Dictionary
" ------------------------------------------------------------------------------
set autoindent					" copy indent from current line
set number						" line numbers
set shiftwidth=4				" Number of spaces to use for each step of indent
set smartindent					" Smart autoindenting when starting a new line
set tabstop=4					" Number of spaces that a <Tab> counts for
"set wildignore=*.bak,*.o,*.e,*~	" wildmenu: ignore these extensions
" ------------------------------------------------------------------------------
"
" ------------------------------------------------------------------------------
" comma always followed by a space
" ------------------------------------------------------------------------------
"inoremap  ,  ,<Space>
"
" ------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
" ------------------------------------------------------------------------------
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
"
"vnoremap ( s()<Esc>P<Right>%
"vnoremap [ s[]<Esc>P<Right>%
"vnoremap { s{}<Esc>P<Right>%
" ==============================================================================
"  VARIOUS PLUGIN CONFIGURATIONS
" ==============================================================================
" 
" ------------------------------------------------------------------------------
" c.vim
" ------------------------------------------------------------------------------
helptags $HOME/.vim/doc			" Help tabs
"let g:C_UseTool_doxygen='yes' 	" Doxygen 
"
" Use Vim settings, rather than Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" line numbering
set number

" Color scheme
colorscheme darkblue

" Highlight end of column
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" Tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

" Enable the mouse
if has('mouse')
	set mouse=a
endif

"" Open NerdList
"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Remap esc
imap qq <Esc>

" Remap for closing buffers
"nnoremap <leader>q :bp<cr>:bd #<cr>

" Remap keys for buffer switching
map <F2> :bprevious<CR>
map <F3> :bnext<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Add .m suffixes when searching for files
set suffixesadd+=.m

" Setup environment
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
"function! SetupEnvironment()
"	let l:path = expand( '%:p' )
"	if l:path =~ '/cygdrive/d/MatlabKernels'
"		let &path.="/cygdrive/d/MatlabKernels/**"
"	endif
"endfunction
"autocmd! BufReadPost,BufNewFile * call SetupEnvironment()

" Display all matching files for tab complete
set wildmenu

" TAG jumping 
command! MakeTages !ctags -R .

"autocmd BufEnter *.tex filetype plugin on|set shellslash| set grepprg=grep\ -nH\ $*|filetype indent on|let g:tex_flavor='latex'|set iskeyword+=: 
"" -----------
" Vim-Latex
" Make vim invoke Latex-Suite when you open a tex file
filetype plugin on
"
"" grep will sometimes skip displaying the file name if you search in a single
"" file. This will confuse Latex-Suite. Set your grep program to always
"" generate a file-name
"set grepprg=grep\ -nH\ $*

" Enable automatic indentation as you type
"TODO: only enable for tex files
"autocmd filetype latex indent on

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
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'C:/Users/cellism7/AppData/Local/Apps/Evince-2.32.0.145/bin/evince.exe'

"" -----------

" Deal with the colors in vimdiff
if &diff
	colorscheme evening
endif


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
	execute "normal! o% © " . strftime("%Y") . ". Johnson Controls, Inc. All rights reserved."
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
" EOF
