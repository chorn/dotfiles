set encoding=utf-8
scriptencoding

function! SafeDirectory(dir)
  let l:expanded = expand(a:dir)
  if !isdirectory(l:expanded)
    call mkdir(l:expanded, 'p', 0700)
  endif
  return l:expanded
endfunction

if has('nvim')
  let g:vimhome = SafeDirectory('~/.config/nvim')
  set shada='100,<1000,s1000,:1000
else
  let g:vimhome = SafeDirectory('~/.vim')
  set clipboard+=autoselect
endif

let &backupdir    = SafeDirectory(g:vimhome . '/backup')
let &directory    = SafeDirectory(g:vimhome . '/swap')
let &viewdir      = SafeDirectory(g:vimhome . '/view')
let &undodir      = SafeDirectory(g:vimhome . '/undo')
let g:autoloadhome = SafeDirectory(g:vimhome . '/autoload')
let g:cachedir     = SafeDirectory(g:vimhome . '/cache')
let g:vimplug_exists = expand(g:autoloadhome . '/plug.vim')

if !filereadable(g:vimplug_exists)
  if !executable('curl')
    echoerr 'You have to install curl or first install vim-plug yourself!'
    execute 'q!'
  endif
  echo 'Installing Vim-Plug...'
  execute 'silent !curl -sflo ' . g:autoloadhome . '/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  augroup InstallPlug
    autocmd VimEnter * PlugInstall
  augroup END
endif

set autoindent
set background=dark
set backspace=indent,eol,start
set backup
set binary
set clipboard+=unnamedplus
set cmdheight=3
set nocompatible
set completeopt=menu,menuone,preview,noinsert
set cursorline
set display+=lastline
set noexrc
set noerrorbells
set encoding=utf-8
set expandtab
set exrc
set nofoldenable
set foldmethod=marker
set foldopen+=jump
set formatoptions=rq
set guioptions+=P
set nohidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nolazyredraw
set list
set listchars=tab:··,trail:·,nbsp:■,extends:>,precedes:<
set matchtime=5
set maxmempattern=8192
set modeline
set modelines=8
set mouse+=a
set number
set numberwidth=6
set preserveindent
set redrawtime=1000
set report=0
set ruler
set scrolljump=5
set scrolloff=1
set secure
set shiftround
set shiftwidth=2
set shortmess+=A " Hide swap file warnings
set shortmess+=I " Hide splash screen
set shortmess+=W " Hide file written message
set shortmess+=a " Abbreviate various messages
set shortmess+=c " Hide completion messages
set noshowcmd
set showmatch
set sidescrolloff=5
set signcolumn=yes
set noshowmode
set showtabline=1
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set tags=./tags;,~/.vimtags
set noterse
set viminfo='100,<1000,s1000,:1000
set visualbell
set t_vb=
set t_Co=256
set termguicolors
set ttimeout
set ttimeoutlen=50
set undofile
set undolevels=10000
set undoreload=100000
set updatetime=300
set winaltkeys=no
set wildignore+=tags,*/.cache/*,*/tmp/*,*/.git/*,*/.svn/*,*.log,*.so,*.swp,*.zip,*.gz,*.bz2,*.bmp,*.ppt,.DS_Store
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.dll
set wildmenu
set wildmode=list:longest:full
set writebackup

call plug#begin(SafeDirectory(g:vimhome . '/plugged'))

Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'chrisbra/csv.vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'simeji/winresizer'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/context.vim'

call plug#end()
runtime! macros/matchit.vim

if exists($TMUX)
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:mapleader = ','
" let g:is_bash = 1

let g:airline_extensions = ['ale', 'branch', 'bufferline', 'csv', 'fugitiveline', 'fzf', 'hunks', 'keymap', 'languageclient', 'lsp', 'netrw', 'quickfix', 'searchcount', 'tabline', 'term', 'virtualenv', 'whitespace', 'wordcount']
let g:airline#extensions#tabline#formatter         = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers      = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits       = 0
let g:airline#extensions#tabline#show_tab_nr       = 0
let g:airline#extensions#tabline#show_tab_type     = 0
let g:airline#extensions#tabline#show_tabs         = 0
let g:airline#extensions#tabline#tab_nr_type       = 1
let g:airline_detect_crypt                         = 1
let g:airline_detect_iminsert                      = 1
let g:airline_detect_modified                      = 1
let g:airline_detect_paste                         = 1
let g:airline_detect_spell                         = 1
let g:airline_experimental                         = 1
let g:airline_inactive_collapse                    = 1
let g:airline_powerline_fonts                      = 1
let g:airline_skip_empty_sections                  = 1
let g:airline_theme                                = 'tomorrow'

let g:ale_set_balloons                   = 1
let g:ale_change_sign_column_color       = 1
let g:ale_completion_autoimport          = 1
let g:ale_completion_enabled             = 1
let g:ale_disable_lsp                    = 0
let g:ale_emit_conflict_warnings         = 1
let g:ale_fix_on_save                    = 1
let g:ale_floating_preview               = 1
let g:ale_javascript_eslint_use_global   = 0
let g:ale_javascript_flow_use_global     = 0
let g:ale_javascript_standard_use_global = 0
let g:ale_javascript_xo_use_global       = 0
let g:ale_linters_explicit               = 0
let g:ale_lint_delay                     = 50
let g:ale_lint_on_enter                  = 1
let g:ale_lint_on_insert_leave           = 1
let g:ale_ruby_rubocop_options           = '-EDS'
let g:ale_sh_shellcheck_dialect          = 'bash'
let g:ale_sh_shellcheck_options          = '-x'
let g:ale_sh_shfmt_options               = '-i 2 -bn -ci -sr'
let g:ale_sign_column_always             = 1
let g:ale_sign_error                     = 'E'
let g:ale_sign_warning                   = 'W'
let g:ale_use_global_executables         = 1
let g:ale_linters                        = {
  \ 'sh': ['language_server', 'shell', 'shellcheck', 'shfmt'],
\ }
let g:ale_fixers                         = {
  \  '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'sh': ['shfmt'],
  \ 'javascript': ['eslint'],
  \ 'ruby': ['rubocop'],
  \ 'typescript': ['eslint'],
\ }
let g:ale_pattern_options                = {
  \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
  \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:asyncomplete_auto_completeopt = 0

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Use ALE's function for asyncomplete defaults
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options())

" fzf
let g:fzf_preview_window = 'right:60%'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'down': '~75%' }
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
noremap <C-p> :Files<cr>

" gitgutter
highlight clear SignColumn
let g:gitgutter_eager     = 0
let g:gitgutter_enabled   = 1
let g:gitgutter_max_signs = 10000
let g:gitgutter_realtime  = -1

" nerdtree
nmap <leader>n :NERDTreeToggle<CR>
vmap <leader>n :NERDTreeToggle<CR>

" ruby
let g:ruby_fold = 1
let g:ruby_foldable_groups = ''
let g:ruby_space_errors = 1
let g:ruby_spellcheck_strings = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1

" splitjoin.vim
nmap <leader>sj :SplitjoinJoin<cr>
nmap <leader>ss :SplitjoinSplit<cr>

" tcomment_vim
map \\ gcc
vmap \\ gc
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif
let g:tcomment_types = { 'java' : '// %s' }
let g:tcomment_types = { 'tmux' : '# %s' }

" winresizer
let g:winresizer_start_key = '<C-e>'
nmap <C-e> :WinResizerStartResize\n

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup RememberLastPosition
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd BufReadPost COMMIT_EDITMSG,PULLREQ_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

augroup GitCommits
  autocmd FileType gitcommit nested setlocal spell
augroup END

augroup JSON
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

autocmd VimResized * :wincmd =

imap jk <Esc>
nmap jk <Esc>
vmap jk <Esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <M-f> e
nmap <M-b> b

noremap <Tab> gT
noremap <S-Tab> gt
noremap <leader>[ gt
noremap <leader>] gT
noremap <leader>` :tabnew<CR>

nmap d[ [m
nmap d] ]m
nmap c[ [[
nmap c] ]]

nmap <CR> :nohlsearch<cr>
vmap < <gv
vmap > >gv
vmap <Tab> >gv
vmap <S-Tab> <gv
cmap %% <C-R>=expand('%:h').'/'<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

function ShutUp()
  :ALEToggle
  set nonumber
  sign unplace *
endfunction
nmap <silent> <leader>z :call ShutUp()<CR>

syntax on
filetype plugin indent on

if exists('$BASE16_THEME') && isdirectory(expand(g:vimhome . '/plugged/base16-vim'))
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
  hi LineNr ctermfg=236 ctermbg=234
  hi Error ctermfg=11 ctermbg=none guifg='#ffff00' guibg='#000000'
endif

" if has('gui_running')
"   set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h15
"   set guioptions+=a
"   set guioptions-=m  "remove menu bar
"   set guioptions-=T  "remove toolbar
"   set guioptions-=L  "remove toolbar
"   set guioptions-=r  "remove toolbar
"   set antialias
"   set cursorline
"   set mousehide
" endif
