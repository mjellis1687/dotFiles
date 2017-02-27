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
" EOF
