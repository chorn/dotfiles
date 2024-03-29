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
  set clipboard+=unnamedplus
else
  let g:vimhome = SafeDirectory('~/.vim')
  set clipboard+=unnamedplus
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

call plug#begin(SafeDirectory(g:vimhome . '/plugged'))

" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --no-update-rc --key-bindings --completion' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch' : 'release' }
" Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'simeji/winresizer'
Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'wellle/context.vim'

" Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }


" Filetypes
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'neoclide/jsonc.vim',                     { 'for': ['json', 'jsonc'] }
" Plug 'JulesWang/css.vim',                      { 'for': [ 'css', 'sass', 'scss' ] }
" Plug 'ambv/black',                             { 'for': 'python' }
" Plug 'chrisbra/csv.vim',                       { 'for': 'csv' }
" Plug 'elixir-lang/vim-elixir',                 { 'for': 'elixir' }
" Plug 'fatih/vim-go',                           { 'for': 'go' }
" Plug 'isRuslan/vim-es6',                       { 'for': 'javascript' }
" Plug 'kchmck/vim-coffee-script',               { 'for': 'coffee' }
" Plug 'leafgarland/typescript-vim',             { 'for': 'typescript' }
Plug 'martinda/Jenkinsfile-vim-syntax'
" Plug 'moll/vim-node',                          { 'for': 'javascript' }
" Plug 'othree/es.next.syntax.vim',              { 'for': 'javascript' }
" Plug 'othree/html5.vim',                       { 'for': 'html' }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
" Plug 'othree/yajs.vim',                        { 'for': 'javascript' }
" Plug 'plasticboy/vim-markdown',                { 'for': 'markdown' }
" Plug 'racer-rust/vim-racer',                   { 'for': 'rust' }
" Plug 'rhysd/vim-crystal',                      { 'for': 'crystal' }
" Plug 'rust-lang/rust.vim',                     { 'for': 'rust' }
" Plug 'spiegela/vimix',                         { 'for': 'elixir' }
" Plug 'thoughtbot/vim-rspec',                   { 'for': 'ruby' }
" Plug 'tmux-plugins/vim-tmux',                  { 'for': 'tmux' }
" Plug 'tpope/vim-bundler',                      { 'for': 'ruby' }
" Plug 'tpope/vim-endwise',                      { 'for': 'ruby' }
" Plug 'tpope/vim-haml',                         { 'for': 'haml' }
" Plug 'tpope/vim-rails',                        { 'for': 'ruby' }
" Plug 'tpope/vim-rake',                         { 'for': 'ruby' }
" Plug 'vim-ruby/vim-ruby',                      { 'for': 'ruby' }
" Plug 'vito-c/jq.vim',                          { 'for': 'jq' }

call plug#end()
runtime! macros/matchit.vim

set autoindent
set background=dark
set backspace=indent,eol,start
set backup
set binary
set cmdheight=3
set completeopt=menu,menuone,preview,noinsert
set cursorline
set display+=lastline
set noexrc
set noerrorbells
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

if exists($TMUX)
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:mapleader = ','
let g:is_bash = 1

" airline
"if exists('g:airline_theme')
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.crypt                        = '🔒'
  let g:airline_symbols.maxlinenr                    = '☰'
  let g:airline_symbols.spell                        = 'Ꞩ'
  let g:airline_symbols.notexists                    = '∄'
  let g:airline_symbols.whitespace                   = 'Ξ'
  let g:airline#extensions#ale#enabled               = 1
  let g:airline#extensions#branch#enabled            = 1
  let g:airline#extensions#bufferline#enabled        = 1
  let g:airline#extensions#csv#enabled               = 1
  let g:airline#extensions#hunks#enabled             = 1
  let g:airline#extensions#tabline#enabled           = 0
  let g:airline#extensions#tagbar#enabled            = 1
  let g:airline#extensions#vimagit#enabled           = 1
  let g:airline#extensions#nrrwrgn#enabled           = 1
  let g:airline#extensions#yc#enabled                = 1
  let g:airline_detect_crypt                         = 1
  let g:airline_detect_iminsert                      = 1
  let g:airline_detect_modified                      = 1
  let g:airline_detect_paste                         = 1
  let g:airline_inactive_collapse                    = 1
  let g:airline_powerline_fonts                      = 1
  let g:airline_theme                                = 'tomorrow'
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_buffers      = 1
  let g:airline#extensions#tabline#show_splits       = 0
  let g:airline#extensions#tabline#show_tabs         = 0
  let g:airline#extensions#tabline#show_tab_nr       = 0
  let g:airline#extensions#tabline#show_tab_type     = 0
  let g:airline#extensions#tabline#tab_nr_type       = 1
  let g:airline#extensions#tabline#formatter         = 'unique_tail_improved'
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  nmap <leader>- <Plug>AirlineSelectPrevTab
  nmap <leader>+ <Plug>AirlineSelectNextTab
"endif

"if exists('g:ale_linters')
  let g:ale_set_balloons = 1
  let g:ale_change_sign_column_color = 1
  " let g:ale_completion_enabled = 0
  let g:ale_completion_enabled = 1
  " let g:ale_disable_lsp = 1
  let g:ale_disable_lsp = 0
  let g:ale_emit_conflict_warnings = 1
  let g:ale_fix_on_save = 1
  let g:ale_floating_preview = 1
  let g:ale_javascript_eslint_use_global = 0
  let g:ale_javascript_flow_use_global = 0
  let g:ale_javascript_standard_use_global = 0
  let g:ale_javascript_xo_use_global = 0
  let g:ale_linters_explicit = 0
  let g:ale_lint_delay = 50
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_ruby_rubocop_options = '-EDS'
  let g:ale_sh_shellcheck_dialect = 'bash'
  let g:ale_sh_shellcheck_options = '-x'
  let g:ale_sh_shfmt_options = '-i 2 -bn -ci -sr'
  let g:ale_sign_column_always = 1
  let g:ale_sign_error = 'E'
  let g:ale_sign_warning = 'W'
  let g:ale_use_global_executables = 1
  let g:ale_linters = {
    \ 'sh': ['language_server', 'shellcheck', 'shfmt'],
  \ }
  let g:ale_fixers = {
    \ 'sh': ['shfmt'],
    \ 'javascript': ['eslint'],
    \ 'ruby': ['rubocop'],
    \ 'typescript': ['eslint'],
  \ }
  let g:ale_pattern_options = {
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
  \}
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
"endif


" bufferline
let g:bufferline_active_buffer_left  = '['
let g:bufferline_active_buffer_right = ']'
let g:bufferline_echo                = 0
let g:bufferline_modified            = '+'
let g:bufferline_rotate              = 0
let g:bufferline_show_bufnr          = 1
let g:bufferline_solo_highlight      = 1


" coc
" if exists('g:coc_workspace_initialized')
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ }

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"


" endif

" " context
" nnoremap <silent> <expr> <C-y> context#util#map('<C-Y>')
" nnoremap <silent> <expr> <C-h> context#util#map('<C-E>')
" nnoremap <silent> <expr> zz    context#util#map('zz')
" nnoremap <silent> <expr> zb    context#util#map('zb')
" nnoremap <silent> <expr> zt    context#util#map_zt()
" nnoremap <silent> <expr> H     context#util#map_H()


" fzf
if has('nvim')
  function! s:fzf_statusline()
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  augroup FZF
    autocmd! User FzfStatusLine call <SID>fzf_statusline()
  augroup END
endif

let g:fzf_preview_window = 'right:60%'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = { 'down': '~75%' }
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
"
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--info=inline']}, <bang>0)

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
noremap <C-p> :Files<cr>


" " gitgutter
" highlight clear SignColumn
" let g:gitgutter_eager     = 0
" let g:gitgutter_enabled   = 1
" let g:gitgutter_max_signs = 10000
" let g:gitgutter_realtime  = -1


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


" " splitjoin.vim
" nmap <leader>sj :SplitjoinJoin<cr>
" nmap <leader>ss :SplitjoinSplit<cr>


" " tabular
" nmap <leader>a= :Tabularize /=<CR>
" vmap <leader>a= :Tabularize /=<CR>
" nmap <leader>a: :Tabularize /:\zs<CR>
" vmap <leader>a: :Tabularize /:\zs<CR>

" tcomment_vim
"if exists('tcomment#options')
  map \\ gcc
  vmap \\ gc
  if !exists('g:tcomment_types')
    let g:tcomment_types = {}
  endif
  let g:tcomment_types = { 'java' : '// %s' }
  let g:tcomment_types = { 'tmux' : '# %s' }
" endif

" " winresizer
" let g:winresizer_start_key = '<C-e>'
" nmap <C-e> :WinResizerStartResize\n

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup RememberLastPosition
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd BufReadPost COMMIT_EDITMSG,PULLREQ_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

augroup GitCommits
  autocmd FileType gitcommit nested setlocal spell
augroup END

" augroup Python
"   autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent
"   autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
" augroup END

augroup JSON
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

augroup ContentShellScript
  au! BufRead,BufNewFile,BufEnter */src/content/*/*.sh setlocal noexpandtab
augroup END

autocmd VimResized * :wincmd =

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Just for TMUX
" if v:version > 704
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if has('nvim')
"   tnoremap <C-w> <C-\><C-N><C-w>
" endif

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

" function ShutUp()
"   :ALEToggle
"   set nonumber
"   sign unplace *
" endfunction
" nmap <silent> <leader>z :call ShutUp()<CR>

syntax on
filetype plugin indent on

if exists('$BASE16_THEME') && isdirectory(expand(g:vimhome . '/plugged/base16-vim'))
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
  hi LineNr ctermfg=236 ctermbg=234
  hi Error ctermfg=11 ctermbg=none guifg='#ffff00' guibg='#000000'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h15
  set guioptions+=a
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=L  "remove toolbar
  set guioptions-=r  "remove toolbar
  set antialias
  set cursorline
  set mousehide
endif

