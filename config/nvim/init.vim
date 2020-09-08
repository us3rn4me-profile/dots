" This dotfile require node, npm, fzf, ctags, git
" Plugins {{{
call plug#begin()
" Themes
Plug 'joshdick/onedark.vim'                         " OneDark
Plug 'reedes/vim-colors-pencil'                     " Pencil colors
Plug 'chriskempson/base16-vim'                      " Base16 theme
Plug 'sjl/badwolf'                                  " Badwolf theme
Plug 'sheerun/vim-polyglot'                         " Syntax
Plug 'gorodinskiy/vim-coloresque'                   " Colors in CSS

" Editor UX
Plug 'jiangmiao/auto-pairs'                         " Brackets
Plug 'dense-analysis/ale'                           " ALE
Plug 'majutsushi/tagbar'                            " Tagbar
Plug 'junegunn/fzf.vim'                             " FZF
Plug 'airblade/vim-gitgutter'                       " Git Integration
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " COC
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " Snippets
Plug 'tomtom/tcomment_vim'                          " Commenter
Plug 'preservim/nerdtree'                           " File Browser
call plug#end()

" }}}
" Imports {{{
source $HOME/.config/nvim/coc.vim                   " Default coc settings
source $HOME/.config/nvim/rules.vim                 " Rules for files
" }}}
" Settings {{{
syntax on                                           " Syntax now on
let &t_ut=''                                        " Normal rendering in Kitty
colorscheme badwolf                                 " Define Colorscheme
if (has("termguicolors"))                           " Terminal colors in GUI app
        set termguicolors
endif
set encoding=utf-8                                  " UTF-8 - basic encoding
set history=500                                     " Sets how many lines of history VIM has to remember
set wildmenu                                        " Extensive command menu
set showcmd                                         " Show last command in panel (keys)
set lazyredraw                                      " Don't redraw, when using macros
set laststatus=0                                    " Don't show blue status line
set cmdheight=1                                     " Commandline height
set ignorecase                                      " Ignore case when searching
set smartcase                                       " Ignore case, if there is only small letters
set incsearch                                       " Move cursor, when searching
"set hlsearch                                        " Highlight search results
set autoread                                        " If file changes, then re-read it
filetype plugin on                                  " Plugins now know type of file (extension after .)
filetype indent on                                  " Indent file with special indentation (default indentation for file)
set list listchars=tab:»\ ,trail:·,nbsp:·           " Set characters for showing trailing spaces or tabs
set tags^=.git/tags                                 " Use tags file (it will be searched in .git folder)
set confirm                                         " Confirm dialog with abillity to save files, if anything fails
set showmatch                                       " Show matching paranthesis
set expandtab                                       " Spaces instead of tabs
set tabstop=2                                       " 1 tab = 4 spaces
set shiftwidth=2                                    " 1 tab = 4 spaces
set softtabstop=2
set ai                                              " Auto indent
set si                                              " Smart indent

if has('nvim')                                      " Neovim settings
        set clipboard=unnamedplus                   " Use OS clipboard
endif

" }}}
" Plugin's Configurations {{{
" ALE {{{
let g:ale_sign_error = 'e'                          " Error symbol in side-panel
let g:ale_sign_warning = '!'                        " Warning symbol in side-panel

let g:ale_lint_on_text_changed = 'never'            " Never lint text, when text changes
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1                          " Lint text on save
let g:ale_fix_on_save = 1                           " Fix all possible errors on file save
" Linters
let g:ale_linters = {
			\   'javascript': ['jshint'],
			\   'python': ['flake8', 'pylint']
			\ }
let g:ale_fixers = {
			\ '*': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'python': ['autopep8'],
			\ 'javascript': ['prettier', 'eslint'],
			\ 'go': ['gofmt', 'goimports'],
			\ 'rust': ['rustfmt']
			\}


highlight clear ALEErrorSign                       " Remove background color on errors
highlight clear ALEWarningSign                     " Remove background color on warnings

" }}}
" Base16 Tweaks {{{
let base16colorspace=256                            " Let base16 be 256color, if it possible
" }}}
" Badwolf Tweaks {{{
let g:badwolf_tabline = 0
let g:badwolf_css_props_highlight = 1
" }}}
" NEDRTree {{{
" Autostart if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Autostart if directory was opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Hotkey to open file browser
map <C-n> :NERDTreeToggle<CR>
" }}}
" Commenter {{{

" }}}
" GitGutter {{{
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
highlight GitGutterAdd    guifg=#44CF6C ctermfg=2
highlight GitGutterChange guifg=#FCDC4D ctermfg=3
highlight GitGutterDelete guifg=#E63B2E ctermfg=1

" }}}
" fzf {{{
" Command to generate tags
let g:fzf_tags_command = 'ctags -R'
" }}}

" COC INSTALL PLUGINS
nmap <C-h> :CocInstall coc-python coc-tslint coc-emmet coc-snippets<CR>
" }}}
"Shortcuts {{{
" Functions {{{
function! UpdateTags()                              " Update tags function
  execute ":!ctags -f .git/tags --exclude={.git,node_modules} --tag-relative -R ./*"
  echo "Tags updated"
endfunction
" }}}
let mapleader = ";"                                 " Let leader key be ';'
nmap <leader>tt :tabnew<CR>:FZF<CR>                 " t - tab, t - new (like in browsers)
nmap <leader>tw :tabclose<CR>                       " t - tab, w - close (like in browsers)
nmap <leader>i :tabprev<CR>
nmap <leader>o :tabnext<CR>
nmap <leader>a :TagbarToggle<CR>
nmap <leader>ft :call UpdateTags()<CR>              " Update tags (f - function, t - tags)

" Tcomment
nmap <leader>c :TComment<CR>
vmap <leader>c :TCommentBlock<CR>
" }}}
" vim:fdm=marker
