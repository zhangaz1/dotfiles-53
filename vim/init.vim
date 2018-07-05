set encoding=utf-8
scriptencoding utf-8

augroup vimrc
    autocmd!
augroup END

" General Notes
" * see ":h normal-index" or ":h insert-index" for a list of built-in mappings
" * see ":verbose nmap <C-j>" (for example) for maps setup by plugins or .vimrc
" * profile startup time with "vim --startuptime startup.log"
"
" Reminder (since this file now has folds): zR to open all folds in a file, zM to close them all
" zO to open recursively from cursor, zA to toggle recursively
" See :help fold-manual

" {{{ Plugin setup via vim-plug
" ==============================================================================
" * Run :PlugInstall to install
" * Run :PlugUpdate to update
"
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'w0rp/ale',                    { 'tag': 'v2.0.0' }
Plug 'vim-airline/vim-airline',     { 'tag': 'v0.9' }
Plug 'justinmk/vim-sneak',          { 'commit': '9eb89e4' }
Plug 'dyng/ctrlsf.vim',             { 'commit': 'bf3611c' }
Plug 'junegunn/fzf',                { 'tag': '0.16.6', 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',            { 'commit': '4b9e2a0' }
Plug 'roxma/nvim-completion-manager',  { 'commit': '3ef5ade3' }
Plug 'autozimu/LanguageClient-neovim', { 'tag': '0.1.94', 'do': 'bash install.sh' }
Plug 'airblade/vim-gitgutter',      { 'commit': 'ad25925' }
Plug 'scrooloose/nerdtree'

" tpope appreciation section
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-repeat',            { 'commit': '7a6675f' }     " Enable . repeat for plugin operations (eg. gitgutter)
Plug 'tpope/vim-obsession',         { 'commit': '4ab72e0' }     " start a session file with :Obsession
Plug 'tpope/vim-surround',          { 'commit': '42e9b46' }
Plug 'tpope/vim-unimpaired',        { 'commit': '11dc568' }
Plug 'tpope/vim-fugitive',          { 'commit': '935a2cc' }
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }

" Yanking and clipboard
Plug 'bfredl/nvim-miniyank',           { 'commit': 'b263f7c' }
Plug 'machakann/vim-highlightedyank',  { 'commit': '5fb7d0f' }

" Editing modifications
Plug 'AndrewRadev/splitjoin.vim',   { 'commit': '26e9e9b' }     " gS and gJ to split/join lines
Plug 'jiangmiao/auto-pairs',        { 'commit': 'f0019fc' }
Plug 'tomtom/tcomment_vim',         { 'commit': '3d0a997' }

" Additional text objects
" They're basically all based on vim-textobj-user. For more, see https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'
Plug 'jceb/vim-textobj-uri'                     " eg. viu
Plug 'kana/vim-textobj-indent'                  " eg. vii
Plug 'Julian/vim-textobj-variable-segment'      " eg. viv
Plug 'whatyouhide/vim-textobj-xmlattr'          " eg. vix

" Indentation, etc. Autodetect, but override with .editorconfig if present:
" Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' }   " TODO: load lazily, w/o input lag

" Javascript/CSS/HTML-related plugins
Plug 'othree/csscomplete.vim',      { 'for': ['css', 'stylus', 'less'] }
Plug 'tpope/vim-ragtag',            { 'commit': '0ef3f6a', 'for': ['html', 'xml', 'javascript'] }
Plug 'mhartington/nvim-typescript', { 'commit': 'f33d0bc', 'for': ['typescript'], 'do': ':UpdateRemotePlugins' }

" Other language-specific plugins
Plug 'reasonml-editor/vim-reason-plus',  { 'for': ['reason'] }
Plug '~/dotfiles/vim/downloaded_plugins/dbext', {'for': ['sql']}
Plug 'elzr/vim-json',               { 'commit': 'f5e3181', 'for': ['json'] }
Plug 'junegunn/vim-xmark',          { 'commit': '6dd673a', 'do': 'make', 'for': 'markdown' }

" Color/Theme/syntax related plugins
Plug 'morhetz/gruvbox',             { 'commit': '2ea3298' }     " default colorscheme. brown/retro. :set bg=dark
Plug 'sheerun/vim-polyglot',        { 'commit': 'a61ab44' }     " syntax highlighting for many languages
Plug 'lilydjwg/colorizer',          { 'commit': '9d6dc32', 'on': 'ColorToggle' }

" Misc
Plug 'vimwiki/vimwiki',             { 'tag':    'v2.2.1'  }
Plug 'Valloric/ListToggle',         { 'commit': '2bc7857' }
Plug 'danro/rename.vim',            { 'commit': 'f133763' }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neosnippet',           { 'commit': 'f775508' }

" Enabled periodically, but not by default:
" Plug 'takac/vim-hardtime',          { 'commit': 'acf59c8' }
" Plug 'mbbill/undotree',             { 'commit': '39e5cf0' }
" Plug 'tweekmonster/startuptime.vim'
" Plug 'troydm/zoomwintab.vim',       { 'commit': 'b7a940e' }

call plug#end()

" }}}
" {{{ General Vim settings
" ==============================================================================

let g:mapleader = ' '         " <leader> is our personal modifier key
set visualbell
set history=500             " longer command history (default=20)
set backspace=indent,eol,start
set noswapfile              " Disable swap files
set backupcopy=yes
set lazyredraw              " Speeds up macros by avoiding excessive redraws

" File/buffer settings
set hidden                  " TODO: revisit this. Hides instead of unloads buffers
set autoread                " reload files on changes (ie. changing git branches)
set scrolloff=3             " # of lines always shown above/below the cursor

" Indenting & white space
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set breakindent
set showbreak=…
set list listchars=tab:›\ ,trail:·          " mark trailing white space

" }}}
" {{{ Display/window settings
"===============================================================================
syntax on
set number                  " line number gutter
set ruler                   " line numbers at bottom of page
set showcmd
set title
set wildmenu
set wildignore=.svn,.git,.gitignore,*.pyc,*.so,*.swp,*.jpg,*.png,*.gif,node_modules,_site
set laststatus=2            " Always show a status line for lowest window in a split
set cursorline              " highlight the full line that the cursor is currently on
set colorcolumn=80,100      " Highlight these columns with a different bg

" Automatically set quickfix height
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
autocmd vimrc FileType qf call AdjustWindowHeight(4, 24)       " 2nd arg=> max height
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line('$'), a:maxheight]), a:minheight]) . 'wincmd _'
endfunction

" }}}
" {{{ Searching & Replacing
"===============================================================================
set ignorecase
set smartcase               " override 'ignorecase' if search term has upper case chars
set incsearch               " incremental search
set showmatch
set hlsearch                " highlight searched items
set gdefault                " use 'global' mode by default for substitutions

" Clear search highlighting with ' ,', use python-style search regexes:
nnoremap <leader>, :noh<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" }}}
" {{{ Line wrapping
"===============================================================================
set wrap
set textwidth=99
set formatoptions=qrn1j
nnoremap j gj
nnoremap k gk

" }}}
" {{{ Neovim-specific settings
"===============================================================================
if has('nvim')
    " True Color support- requires recent versions of iTerm2 and tmux (2.2+)
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let &t_8b="\e[48;2;%ld;%ld;%ldm"

    set inccommand=split

    " See https://github.com/neovim/neovim/wiki/FAQ
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

    tnoremap <esc> <c-\><c-n>
    autocmd vimrc WinEnter term://* call feedkeys('i')
elseif $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color'
    set t_Co=256    " 256 colours for regular vim if the terminal can handle it.
endif

" }}}
" {{{ Colorscheme & syntax
"===============================================================================
color gruvbox
set background=dark
highlight Comment cterm=italic

" highlight trailing whitespace and excessive line length:
augroup ErrorHighlights
    autocmd!
    autocmd InsertEnter * call clearmatches()
    autocmd InsertLeave * call matchadd('ErrorMsg', '\s\+$', 100) | call matchadd('ErrorMsg', '\%>140v.\+', 100)
augroup END

" Show syntax highlighting groups for word under cursor with <leader>s
" From Vimcasts #25: http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader>S :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}
" {{{ Autocompletion and Tab behavior
"===============================================================================
" May want to consider replacing "menuone" with "menu" (see vim help)
set completeopt=menuone,preview,longest

" Traverse completions with <Tab>
inoremap <expr> <TAB> pumvisible() ? '<C-n>' : '<TAB>'
inoremap <expr> <S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'

" nvim-completion-manager config
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
"imap <expr> <CR> (pumvisible() ? "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
"imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")

" Extra hack to work around <CR> conflicts with auto-pairs:
"imap <expr> <silent> <cr>  (pumvisible() ? "\<c-y>\<Plug>(cm_inject_snippet)\<Plug>(expand_or_nl)\<c-r>=AutoPairsReturn()\<cr>" : "\<cr>\<c-r>=AutoPairsReturn()\<cr>")

inoremap <C-c> <Esc>
set shortmess+=c

" Extra config to make snippet expansion work correctly with <CR>:
inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>

" LanguageClient integration
" note: also need to install language servers globally (eg with `yarn global add`)
let g:LanguageClient_serverCommands = {
\ 'javascript': ['flow-language-server', '--stdio'],
\ 'javascript.jsx': ['flow-language-server', '--stdio'],
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ 'reason': ['ocaml-language-server', '--stdio'],
\ 'typescript': ['typescript-language-server', '--stdio'],
\ }
let g:LanguageClient_autoStart = 1
autocmd vimrc FileType javascript,javascript.jsx,ocaml,reason,typescript nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <F3> :call LanguageClient_textDocument_formatting()<cr>

" for echodoc; the mode is already visible in airline
set noshowmode

" }}}
" {{{ ALE
"===============================================================================
" Move between errors
nnoremap <silent> <C-j> :call ale#loclist_jumping#Jump('after', 1)<CR>
nnoremap <silent> <C-k> :call ale#loclist_jumping#Jump('before', 1)<CR>

let g:ale_open_list = 0   " Don't open the loclist when reading a file (if there are errors)
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 100
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint', 'tsserver', 'typecheck'],
\}
let g:ale_linter_aliases = {
\   'reason': 'ocaml',
\   'less': 'css'
\}
let g:ale_fixers = {
\   'javascript': ['eslint']
\}
nnoremap <leader>f :ALEFix<CR>

" }}}
" {{{ nerdtree
"===============================================================================

function! IsNerdTreeEnabled()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! OpenNerdTree()
  let l:current_filename = expand('%:t')
  " FIXME: check if current file is visible in nerdtree (need to switch to nerdtree to search):
  " let l:current_file_is_visible = IsNerdTreeEnabled() && search(l:current_filename, 'n') != 0
  let l:current_file_is_visible = IsNerdTreeEnabled()
  if l:current_file_is_visible
    NERDTreeFocus
  else
    NERDTree %
  endif
  call search(l:current_filename)  " move cursor to current file
endfunction

" Note: this opens a fresh tree every time:
" nnoremap - :NERDTree %<CR>
" nnoremap - :NERDTreeToggle %<CR>
nnoremap - :call OpenNerdTree()<CR>

autocmd vimrc FileType nerdtree nmap <buffer> - U
autocmd vimrc FileType nerdtree nmap <buffer> <C-v> s
autocmd vimrc FileType nerdtree nmap <buffer> <C-t> t
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1

" }}}
" {{{ More plugin customization
"===============================================================================

" ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" FZF
" More tips: https://github.com/junegunn/fzf/wiki/Examples-(vim)
nnoremap <leader><leader> :FZF<CR>
nnoremap <C-t> :Buffers<CR>
nnoremap <leader>h :History:<CR>
let g:fzf_action = {
  \'ctrl-s': 'split',
  \'ctrl-v': 'vertical split',
  \'ctrl-t': 'tab split',
  \':': 'close' }

" Custom MRU using FZF
" Based on the example here: https://github.com/junegunn/fzf/wiki/Examples-(vim)
command! FZFMru call fzf#run({
\ 'source':  filter(copy(v:oldfiles), "v:val !~ 'fugitive:\\|__CtrlSF\\|^/tmp/\\|.git/'"),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })
nnoremap gm :FZFMru<CR>

" gitgutter
" use [c and ]c to jump to next/previous changed "hunk"
nmap <leader>a <Plug>GitGutterStageHunk
nmap <leader>r <Plug>GitGutterUndoHunk

" vim-airline:
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_symbols.branch    = '⭠'
let g:airline_symbols.readonly  = '⭤'
let g:airline_symbols.linenr    = '⭡'
let g:airline_theme = 'gruvbox'
let g:airline_extensions = ['ale', 'branch', 'tabline']   " Only enable extensions I use, improves performance
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Colorizer
nnoremap <leader><F2> :ColorToggle<CR>

" Undotree
nnoremap <F3> :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1

" Splitjoin
let g:splitjoin_curly_brace_padding = 0
let g:splitjoin_trailing_comma = 1

" Neosnippet
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/.vim/personal_snippets'
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['jsx'] = 'html'
let g:neosnippet#enable_completed_snippet=1
nnoremap <leader>s :NeoSnippetEdit -vertical -split<CR>

" CtrlSF.vim
let g:ctrlsf_context = '-B 2 -A 2'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '65%'
let g:ctrlsf_indent = 1
let g:ctrlsf_ignore_dir = ['node_modules', '.git']
nnoremap <C-g> :CtrlSF ""<left>
nmap gr <Plug>CtrlSFCCwordExec
let g:ctrlsf_mapping = {
  \'chgmode' : '<A-m',
  \'open'    : '<CR>',
  \'openb'   : ['o', 'O'],
  \'split'   : '<C-s>',
  \'vsplit'  : '<C-v>',
  \'tab'     : '<C-t>',
  \'tabb'    : 't',
  \'popen'   : 'p',
  \'quit'    : 'q',
  \'next'    : '<C-J>',
  \'prev'    : '<C-K>',
  \'pquit'   : 'q',
  \'loclist' : '' }
let g:ctrlsf_auto_focus = {"at": "start"}

" nvim-miniyank (lighter-weight YankRing workalike)
let g:miniyank_maxitems = 25
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
nmap <C-p> <Plug>(miniyank-cycle)

" Auto-pairs
inoremap <silent> <C-l> <ESC>:call AutoPairsJump()<CR>a
let g:AutoPairsShortcutFastWrap = '<C-w>'
let g:AutoPairsMultilineClose = 0

" VimWiki
let g:vimwiki_ext2syntax = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
                    \  'diary_rel_path': 'journal/', 'diary_index': 'index',
                    \  'diary_header': 'Journal', 'diary_sort': 'asc'}]

let g:EditorConfig_core_mode = 'python_external'    " Speeds up load time by ~150ms

" vim-ragtag
let g:ragtag_global_maps = 1
autocmd vimrc FileType html,javascript imap <C-k> <C-x>/

" }}}
" {{{ Key Bindings: Visual mode
"===============================================================================

" Tab modifies indent in visual mode; make < > shifts keep selection
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv
vnoremap < <gv
vnoremap > >gv

" make . and macros work on visual selections (via https://www.reddit.com/r/vim/comments/3y2mgt/)
" Note: the . command must take effect at the start of each line
vnoremap . :norm.<CR>
xnoremap @ :normal @

" Repeat the last used macro:
nnoremap Q @@

" }}}
" {{{ Key Bindings: Moving around
"===============================================================================

" Swap jumplist bindings (left => back, right => forward)
nnoremap <C-o> <C-i>
nnoremap <C-i> <C-o>

" g;    - move back in the change list
" g,    - move forward in the change list
" gi    - move to the last insert, and re-enter insert mode
" {     - move back one paragraph
" }     - move forward one paragraph

" Navigating between buffers:
" These first bindings don't work with nnoremap for some reason (?)
nmap <C-h> <Plug>AirlineSelectPrevTab
nmap <C-l> <Plug>AirlineSelectNextTab
nnoremap <Backspace> <C-^>
nnoremap <silent> <C-u> :bd<CR>
nnoremap <C-n> <c-w>w
" Open new vsplit and move to it:
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>o :only<CR>

" Automatically resize/equalize splits when vim is resized
autocmd vimrc VimResized * wincmd =

" Save current file every time we leave insert mode or leave vim
augroup autoSaveAndRead
    autocmd!
    autocmd InsertLeave,FocusLost * call <SID>autosave()
    autocmd CursorHold * silent! checktime
augroup END

function! <SID>autosave()
    if &filetype !=# 'ctrlsf' && (filereadable(expand('%')) == 1)
        update
        call ale#Queue(0)   " Trigger linting immediately
    endif
endfunction

" <escape> in normal mode also saves
nnoremap <esc> :call <SID>autosave()<CR>

" Swap ` and ' for mark jumping:
nnoremap ' `
nnoremap ` '

" Global mark conventions
" Uppercase marks persist between sessions, so they're useful for accessing
" common files quickly. Make the following dotfiles always accessible:
autocmd vimrc BufLeave vimrc,init.vim     normal! mV
autocmd vimrc BufLeave zshrc              normal! mZ

" Leave a mark behind in the most recently accessed file of certain types.
" via https://www.reddit.com/r/vim/comments/41wgqf/do_you_regularly_use_manual_marks_if_yes_how_do/cz5qfqr
autocmd vimrc BufLeave *.css,*.styl       normal! mC
autocmd vimrc BufLeave *.styl             normal! mS
autocmd vimrc BufLeave *.html             normal! mH
autocmd vimrc BufLeave README.md          normal! mR
autocmd vimrc BufLeave package.json       normal! mP
autocmd vimrc BufLeave *.js,*.jsx         normal! mJ
autocmd vimrc BufLeave *.test.js,*.test.jsx   normal! mT

" automatically close corresponding loclist when quitting a window
autocmd vimrc QuitPre * if &filetype != 'qf' | silent! lclose | endif

" }}}
" {{{ Key Bindings: Misc
"===============================================================================
" Use ':w!!' to save a root-owned file using sudo:
cnoremap w!! w !sudo tee % >/dev/null

" Make n/N always go in consistent directions:
noremap <silent> n /<CR>
noremap <silent> N ?<CR>

" console.log convenience mapping. Inserts a console.log() call with the variable under the cursor
autocmd vimrc FileType javascript nnoremap <Leader>cl yiwoconsole.log(`<c-r>": ${<c-r>"}`)<Esc>hh

" yank to system clipboard:
vnoremap <Leader>y "+y

" Resize window with arrow keys
nnoremap <Left> :vertical resize -4<CR>
nnoremap <Right> :vertical resize +4<CR>
nnoremap <Up> :resize -4<CR>
nnoremap <Down> :resize +4<CR>

" Home row bindings for command mode:
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" }}}
" {{{ Folding
"===============================================================================
set foldlevelstart=99
set foldmethod=syntax
autocmd vimrc FileType vim set foldmethod=marker

" }}}
" {{{ Filetype-specific settings
"===============================================================================
autocmd vimrc BufNewFile,BufRead *.md set filetype=markdown

" sql, see https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1

" html
iabbrev target="_blank" target="_blank" rel="noopener"

" CSS-like autocomplete for preprocessor files:
autocmd vimrc FileType css,sass,scss,stylus,less set omnifunc=csscomplete#CompleteCSS

" JavaScript
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

" JSON files
let g:vim_json_syntax_conceal = 0
autocmd BufRead,BufNewFile *.json set filetype=json

" Vim files (use K to look up the current word in vim's help files)
autocmd vimrc FileType vim setlocal keywordprg=:help

" Hack to open help in vsplit by default
augroup vimrc_help
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

autocmd vimrc FileType gitcommit set tabstop=4
" }}}

" Load any machine-specific config from another file, if it exists
try
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry
