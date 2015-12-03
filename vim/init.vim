" General Notes
" * see ":h normal-index" or ":h insert-index" for a list of built-in mappings
" * see ":verbose nmap <C-j>" (for example) for maps setup by plugins or .vimrc

set nocompatible            " we're using Vim, not Vi

"===============================================================================
" NeoBundle setup
"===============================================================================
" Besides the bundles to install, assume that everything until the end of this
" section is required for NeoBundle's setup process.
if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" vim plugins, managed by NeoBundle
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'bling/vim-airline', 'aef500c426'
NeoBundle 'tomtom/tcomment_vim', '3d0a9975'
NeoBundle 'tpope/vim-repeat', '7a6675f09'       " Enable . repeat for plugin operations (eg. gitgutter)
NeoBundle 'tpope/vim-surround', '42e9b46e'
NeoBundle 'jeetsukumaran/vim-filebeagle', 'abfb7f9d2'
NeoBundle 'tommcdo/vim-exchange', 'b82a774'
NeoBundle 'AndrewRadev/splitjoin.vim', '4b062a' " gS and gJ to split/join lines
NeoBundle 'sheerun/vim-polyglot', '1c21231'     " syntax highlighting for many languages
NeoBundle 'vimwiki/vimwiki', '2c03d8'
NeoBundle 'justinmk/vim-sneak', '9eb89e43'
NeoBundle 'af/YankRing.vim', '0e4235b1'         " using fork, as v18 isn't officially on GH
NeoBundle 'tpope/vim-obsession', '4ab72e07ec'   " start a session file with :Obsession
NeoBundle 'ashisha/image.vim', 'ae15d1c5'       " view images in vim (requires `pip install Pillow`)
NeoBundle 'gabesoft/vim-ags', '182c472'

" Git/VCS related plugins
NeoBundle 'tpope/vim-fugitive', '935a2ccc'
NeoBundle 'airblade/vim-gitgutter', '339f8ba0'

" Indentation, etc. Autodetect, but override with .editorconfig if present:
NeoBundle 'tpope/vim-sleuth', '039e2cd'
NeoBundle 'editorconfig/editorconfig-vim', '77875eff51'

" Javascript and HTML-related plugins
NeoBundle 'moll/vim-node', '07a5e9f91'      " Lazy loading doesn't work for some reason
NeoBundleLazy 'tristen/vim-sparkup', '1375ce1e7', {'autoload':{'filetypes':['html']}}
NeoBundleLazy 'tpope/vim-ragtag', {'autoload':{'filetypes':['html']}}   " Use <C-x>/ to close last open html tag

" Ultisnips (private snippets are stored in this repo)
NeoBundle 'UltiSnips', '3.0'

" theme/syntax related plugins:
NeoBundle 'scrooloose/syntastic', 'c1a209895'
NeoBundle 'colorizer', 'aae6b518'

" Colour schemes:
NeoBundle 'tomasr/molokai', 'e7bcec7573'        " default
NeoBundle 'morhetz/gruvbox', 'ffe202e4'         " brown/retro. :set bg=dark
NeoBundle 'whatyouhide/vim-gotham', '6486e10'

" plugins for colorscheme dev (not tested yet):
" https://github.com/shawncplus/Vim-toCterm
" https://github.com/guns/xterm-color-table.vim

" Try later:
" NeoBundle 'tpope/vim-unimpaired'
" NeoBundle 'zefei/vim-colortuner'
" NeoBundle 'mattn/emmet-vim'
" NeoBundle 'jaxbot/github-issues.vim'          " TODO: configure this

" Tried but disabled for now:
" NeoBundle 'ervandew/supertab', 'c8bfeceb'
" NeoBundle 'Raimondi/delimitMate'       " disabled because of https://github.com/Raimondi/delimitMate/issues/138

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
"===============================================================================
" (End of NeoBundle setup)
"===============================================================================



"===============================================================================
" General Vim settings
"===============================================================================
let mapleader = " "         " <leader> is our personal modifier key
set visualbell
set history=500             " longer command history (default=20)
set backspace=indent,eol,start
set noswapfile              " Disable swap files
"set directory=~/.vim/swp    " where the .swp files go (if enabled)
"set shellpipe=>             " Prevents results from flashing during Ack.vim searches

" File/buffer settings
autocmd BufWinEnter,BufNewFile * silent tabo    " Ensure only one tab is open
set hidden                  " TODO: revisit this. Hides instead of unloads buffers
set autoread                " reload files on changes (ie. changing git branches)
set encoding=utf-8
set scrolloff=3             " # of lines always shown above/below the cursor

" Indenting & white space
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set list listchars=tab:›\ ,trail:·          " mark trailing white space
"set list listchars=tab:›\ ,trail:·,eol:¬   " mark trailing white space (with eol)


"===============================================================================
" Display/window settings
"===============================================================================
syntax on
set bg=dark
set number                  " line number gutter
set ruler                   " line numbers at bottom of page
set showcmd
set title
set wildmenu
set wildignore=.svn,.git,.gitignore,*.pyc,*.so,*.swp,*.jpg,*.png,*.gif,node_modules,_site
set laststatus=2            " Always show a status line for lowest window in a split
set cursorline              " highlight the full line that the cursor is currently on
set colorcolumn=80,100      " Highlight these columns with a different bg
set helpheight=99999        " Hack to make help pages open "fullscreen"

" Automatically set quickfix height
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(3, 30)       " 2nd arg=> max height
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"===============================================================================
" Searching & Replacing
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

"===============================================================================
" Line wrapping
"===============================================================================
set wrap
set textwidth=99
set formatoptions=qrn1
nnoremap j gj
nnoremap k gk

if has('nvim')
    " Neovim True Color support
    " For this to work, need:
    " * a nightly iTerm build
    " * a patched tmux: https://gist.github.com/choppsv1/dd00858d4f7f356ce2cf
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let &t_8b="\e[48;2;%ld;%ld;%ldm"

    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1     " See https://github.com/neovim/neovim/wiki/FAQ

    " Nicer navigation for Neovim's terminal buffers
    " via https://github.com/neovim/neovim/pull/2076#issuecomment-76998265
    tnoremap <esc> <c-\><c-n>
    tnoremap <A-j> <c-\><c-n><c-w>j
    tnoremap <A-k> <c-\><c-n><c-w>k
    tnoremap <A-h> <c-\><c-n><c-w>h
    tnoremap <A-l> <c-\><c-n><c-w>l
    tnoremap <A-v> <c-\><c-n><c-w><c-v>
    tnoremap <A-s> <c-\><c-n><c-w><c-s>
    au WinEnter term://* call feedkeys('i')
endif


"===============================================================================
" Colorscheme
"===============================================================================
color gruvbox
set bg=dark

" MacVim/GVIM and 256-colour term overrides
if has('gui_running')
    set guifont=Monaco:h14      " gvim/mvim: Bump up the default fontsize
elseif $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256            " Richer colours if our terminal can handle it.
endif


" Show syntax highlighting groups for word under cursor with <leader>s
" From Vimcasts #25: http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader>h :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


"===============================================================================
" Plugin customization
"===============================================================================

" FileBeagle
let g:filebeagle_show_hidden = 1        " Use 'gh' to toggle- FileBeagle hides lots by default

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" Ctrl-P
nnoremap <C-t> :CtrlPBuffer<CR>             " Search active buffers
nnoremap <C-m> :CtrlPMRUFiles<CR>
let g:ctrlp_map = '<leader><leader>'    " Search in current directory
let g:ctrlp_open_new_file = 'r'         " Open files in the current window
let g:ctrlp_open_multiple_files = 'i'   " Open each of multiple files in new hidden buffers
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore node_modules -g ""'

" gitgutter
nmap <leader>a <Plug>GitGutterStageHunk
nmap <leader>r <Plug>GitGutterRevertHunk
nmap <C-j> :GitGutterNextHunk<CR>
nmap <C-k> :GitGutterPrevHunk<CR>

" Syntastic display customizations:
" TODO: update colors so they work in console vim also
let syntastic_mode_map = { 'passive_filetypes': ['html'] }  " disable html checking by default
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_sq = 0
let g:syntastic_error_symbol = '!!'
let g:syntastic_warning_symbol = '!!'
hi SyntasticErrorSign guifg=#ff0000
hi SyntasticWarningSign guifg=#ff0000
map <C-e> :lnext<CR>

" Syntastic checker config:
let g:syntastic_javascript_checkers=['jshint', 'jscs']
let g:syntastic_python_checkers=['pyflakes']

" vim-airline:
" Note: the following symbols require a patched font.
" For Monaco, I used https://github.com/fromonesrc/monaco-powerline-vim
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'
let g:airline_theme = 'murmur'
let g:airline#extensions#tabline#enabled = 1    " Tab line at top of window

" Supertab
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextDefaultCompletionType = '<c-n>'
" let g:SuperTabNoCompleteAfter = ['^', ',', ';', '\s']

" Colorizer
nnoremap <leader><F2> :ColorToggle<CR>

" Sparkup
let g:sparkupExecuteMapping = '<C-e>'       " The default mapping

" Splitjoin (javascript setting)
" see https://github.com/AndrewRadev/splitjoin.vim/issues/67#issuecomment-91582205
let g:splitjoin_javascript_if_clause_curly_braces = 'Sj'

" UltiSnips
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['personal_snippets']
let g:UltiSnipsSnippetsDir = '~/.vim/personal_snippets'
nnoremap <leader>s :UltiSnipsEdit<CR>

" Ags.vim
nnoremap <C-g> :Ags 
autocmd FileType agsv nnoremap <C-o> :call AgsOpenItemCloseResults()<CR>
let g:ags_agcontext = 1     " Show one line above and below the match

" Hack to open the current result and close the results window in one keystroke:
autocmd FileType agsv nnoremap <C-o> :call AgsOpenItemCloseResults()<CR>
function! AgsOpenItemCloseResults()
  call ags#openFile(line('.'), 'u', 1)
  call ags#quit()
endfunction

" VimWiki
let g:vimwiki_ext2syntax = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
                    \  'diary_rel_path': 'journal/', 'diary_index': 'index',
                    \  'diary_header': 'Journal', 'diary_sort': 'asc'}]


"===============================================================================
" Key Bindings: Indentation levels
"===============================================================================

" Tab indenting in normal & visual modes
" nnoremap <Tab> >>
" nnoremap <S-Tab> <<
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

"===============================================================================
" Key Bindings: Moving around
"===============================================================================

" (built-in)
" <C-o> - move the cursor position back in the jump list
" <C-i> - move the cursor position forward in the jump list
" g;    - move back in the change list
" g,    - move forward in the change list
" gi    - move to the last insert, and re-enter insert mode
" {     - move back one paragraph
" }     - move forward one paragraph

" Navigating between buffers:
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nnoremap <silent> <C-u> :bd<CR>
nmap <C-q> :1,100bd<CR>

" Easier movement between windows (Neovim only?):
nnoremap <A-j> <c-w>j
nnoremap <A-k> <c-w>k
nnoremap <A-h> <c-w>h
nnoremap <A-l> <c-w>l
vnoremap <A-j> <c-\><c-n><c-w>j
vnoremap <A-k> <c-\><c-n><c-w>k
vnoremap <A-h> <c-\><c-n><c-w>h
vnoremap <A-l> <c-\><c-n><c-w>l
inoremap <A-j> <c-\><c-n><c-w>j
inoremap <A-k> <c-\><c-n><c-w>k
inoremap <A-h> <c-\><c-n><c-w>h
inoremap <A-l> <c-\><c-n><c-w>l
cnoremap <A-j> <c-\><c-n><c-w>j
cnoremap <A-k> <c-\><c-n><c-w>k
cnoremap <A-h> <c-\><c-n><c-w>h
cnoremap <A-l> <c-\><c-n><c-w>l

" Save current file every time we leave insert mode or hit <esc>:
" Note that the autocmd repeats the mapping each time we leave insert mode,
" this doesn't seem to be a problem in practice.
"
" Alternative approaches (which didn't seem to work as well for my needs):
" set autowriteall   (couldn't get this to work)
" :au FocusLost * :wa
" autocmd InsertLeave * if expand('%') != '' | update | endif
" (last one via http://blog.unixphilosopher.com/2015/02/five-weird-vim-tricks.html)
inoremap <esc> <esc>:w<CR>
autocmd InsertLeave * nnoremap <esc> <esc>:w<CR>

" Swap ` and ' for mark jumping:
nnoremap ' `
nnoremap ` '

" Global mark conventions
" Uppercase marks persist between sessions, so they're useful for accessing
" common files quickly. By convention, use the following global marks:
"
" V     - vimrc
" Z     - zshrc
" J     - jshintrc
"
" ProTip: After opening a file with a global mark, you can change vim's cwd to
" the file's location with ":cd %:h"


"===============================================================================
" Key Bindings: Misc
"===============================================================================
" Use ':w!!' to save a root-owned file using sudo:
cmap w!! w !sudo tee % >/dev/null

cnoremap <C-j> <down>
cnoremap <C-k> <up>

set foldlevelstart=10
set pastetoggle=<C-y>   " Had problems with <F2>, see http://stackoverflow.com/q/7885198/351433

" copy/paste with system clipboard:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"===============================================================================
" Filetype-specific settings
"===============================================================================
" filetype detection for syntax highlighting
au BufNewFile,BufRead *.md set filetype=markdown
" Disabled mustache for now, since the polyglot plugin adds ^F when using ragtag:
" au BufNewFile,BufRead *.mustache set filetype=mustache
" autocmd FileType mustache set ft=html.mustache

" JSON files: set filetype to json for syntastic, use js highlighting:
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.json setlocal syntax=javascript


"===============================================================================
" Misc
"===============================================================================

" Set vim's cwd to the closest ancestor dir containing a .git directory
" using "git rev-parse --show-toplevel"
function! MoveToGitDir()
  let filePath = fnamemodify(bufname("%"), ':p:h')
  exe 'cd' fnameescape(filePath)
  let repoPath = system("git rev-parse --show-toplevel")
  let repoPath = substitute(repoPath, '\n$', '', '')    " Remove newline from system() output
  exe 'cd' fnameescape(repoPath)
  echo 'Changed dir to ' . repoPath
endfunc
nnoremap <leader>d :call MoveToGitDir()<CR>