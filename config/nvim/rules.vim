au BufNewFile,BufRead *.py
    \ set tabstop=4         " number of visual spaces per TAB
    \ set softtabstop=4     " number of spaces in tab when editing
    \ set shiftwidth=4      " when using the >> or << commands, shift lines by 4 spaces
    \ set textwidth=100
    \ set expandtab         " expand tabs into spaces
    \ set autoindent
    \ set fileformat=unix
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
