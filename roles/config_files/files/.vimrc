" Colors {{{
syntax enable           " enable syntax processing
" }}}

" Misc {{{
set backspace=indent,eol,start " better backspace option
set pastetoggle=<F3>
" }}}


" Spaces & Tabs {{{
set tabstop=4           " 4 space tab conversion
set softtabstop=4       " 4 space tab while editing
set expandtab           " use spaces for tabs
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}

" UI Layout {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set showmatch           " higlight matching parenthesis
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Folding {{{
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}

" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
" }}}
