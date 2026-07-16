# vim: set ft=lua sw=2 ts=2 expandtab:

vim.g.mapleader      = ','
vim.g.maplocalleader = '\\'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln('Failed to clone lazy.nvim:\n' .. out)
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { 'nvim-treesitter/nvim-treesitter', lazy = false, build = ':TSUpdate' },
    { 'neovim/nvim-lspconfig', lazy = false, dependencies = { { "ms-jpq/coq_nvim", branch = "coq" }, { "ms-jpq/coq.artifacts", branch = "artifacts" }, { 'ms-jpq/coq.thirdparty', branch = "3p" }}},
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'romus204/tree-sitter-manager.nvim',
    'editorconfig/editorconfig-vim',
    'junegunn/vim-easy-align',
    'preservim/nerdtree',
    'simeji/winresizer',
    'tomtom/tcomment_vim',
    'tpope/vim-fugitive',
    'tpope/vim-surround',
    'wellle/context.vim',
    'junegunn/fzf.vim',
    'nvim-lualine/lualine.nvim',
    },
    'saghen/blink.cmp', {
      dependencies = {
        'saghen/blink.lib',
        'rafamadriz/friendly-snippets',
      },
      build = function()
        -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
        -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
        require('blink.cmp').build():pwait()
      end,

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'default' },
        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = true } },
        -- (Default) list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"`
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "rust" }
      },
    },

  install = {
    colorscheme = { 'retrobox' }
  },
})

require("tree-sitter-manager").setup({
  config = function()
    require("tree-sitter-manager").setup({
      ensure_installed = { "bash", "dockerfile", "git_config", "git_rebase", "gitcommit", "gitignore", "go", "html", "javascript", "jq", "json", "lua", "make", "markdown", "nginx", "python", "regex", "ruby", "ssh_config", "tmux", "toml", "typescript", "vim", "vimdoc", "xml", "yaml", "zsh"},
      auto_install = true,
    })
  end
})

require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tomorrow_night',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    -- lualine_a = {},
    -- lualine_b = {},
    -- lualine_c = {'filename'},
    -- lualine_x = {'location'},
    -- lualine_y = {},
    -- lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- -- Options
vim.opt.autoindent     = true
-- vim.opt.background     = 'dark'
-- vim.opt.backspace      = { 'indent', 'eol', 'start' }
-- vim.opt.backup         = true
-- vim.opt.backupdir      = backupdir
-- vim.opt.binary         = true
-- vim.opt.cmdheight      = 3
-- vim.opt.completeopt    = { 'menu', 'menuone', 'preview', 'noinsert' }
-- vim.opt.cursorline     = true
-- vim.opt.directory      = swapdir
-- vim.opt.errorbells     = false
vim.opt.expandtab      = true
-- vim.opt.exrc           = true
-- vim.opt.foldenable     = false
-- vim.opt.foldmethod     = 'marker'
-- vim.opt.formatoptions  = 'rq'
-- vim.opt.hidden         = false
-- vim.opt.history        = 1000
-- vim.opt.hlsearch       = true
-- vim.opt.ignorecase     = true
-- vim.opt.incsearch      = true
-- vim.opt.laststatus     = 2
-- vim.opt.lazyredraw     = false
-- vim.opt.list           = true
-- vim.opt.listchars      = { tab = '··', trail = '·', nbsp = '■', extends = '>', precedes = '<' }
-- vim.opt.matchtime      = 5
-- vim.opt.maxmempattern  = 8192
-- vim.opt.modeline       = true
-- vim.opt.modelines      = 8
-- vim.opt.number         = true
-- vim.opt.numberwidth    = 6
-- vim.opt.preserveindent = true
-- vim.opt.redrawtime     = 1000
-- vim.opt.report         = 0
-- vim.opt.ruler          = true
-- vim.opt.scrolljump     = 5
-- vim.opt.scrolloff      = 1
-- vim.opt.secure         = true
-- vim.opt.shiftround     = true
vim.opt.shiftwidth     = 2
-- vim.opt.showcmd        = false
-- vim.opt.showmatch      = true
-- vim.opt.showmode       = false
-- vim.opt.showtabline    = 1
-- vim.opt.sidescrolloff  = 5
-- vim.opt.signcolumn     = 'yes'
vim.opt.smartcase      = true
vim.opt.smartindent    = true
vim.opt.smarttab       = true
vim.opt.softtabstop    = 2
-- vim.opt.splitbelow     = true
-- vim.opt.splitright     = true
vim.opt.tabstop        = 2
-- vim.opt.tags           = { './tags;', '~/.vimtags' }
-- vim.opt.ttimeout       = true
-- vim.opt.ttimeoutlen    = 50
-- vim.opt.undodir        = undodir
-- vim.opt.undofile       = true
vim.opt.undolevels     = 10000
vim.opt.undoreload     = 100000
vim.opt.updatetime     = 300
-- vim.opt.viewdir        = viewdir
-- vim.opt.visualbell     = true
-- vim.opt.wildmenu       = true
-- vim.opt.wildmode       = { 'list', 'longest', 'full' }
-- vim.opt.winaltkeys     = 'no'
-- vim.opt.writebackup    = true
--
-- vim.opt.display:append('lastline')
-- vim.opt.foldopen:append('jump')
-- vim.opt.shada = "'100,<1000,s1000,:1000"
-- vim.opt.shortmess:append('AIWac')
-- vim.opt.wildignore:append({
--   'tags', '*/.cache/*', '*/tmp/*', '*/.git/*', '*/.svn/*',
--   '*.log', '*.so', '*.swp', '*.zip', '*.gz', '*.bz2', '*.bmp', '*.ppt', '.DS_Store',
--   '*\\tmp\\*', '*.exe', '*.dll',
-- })

vim.g.fzf_preview_window      = 'right:60%'
vim.g.fzf_buffers_jump        = 1
vim.g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
vim.g.fzf_layout              = { down = '~75%' }
vim.g.fzf_action              = { ['ctrl-t'] = 'tab split', ['ctrl-x'] = 'split', ['ctrl-v'] = 'vsplit' }

vim.cmd('colorscheme retrobox')

-- Keymaps
local map = vim.keymap.set

-- NERDTree
map('n', '<leader>n', ':NERDTreeToggle<CR>')
map('v', '<leader>n', ':NERDTreeToggle<CR>')

-- splitjoin
map('n', '<leader>sj', ':SplitjoinJoin<CR>')
map('n', '<leader>ss', ':SplitjoinSplit<CR>')
--
-- tcomment (\\ = two backslashes)
map('n', '\\\\', 'gcc', { remap = true})
map('v', '\\\\', 'gc', { remap = true})

-- -- winresizer
-- map('n', '<C-e>', ':WinResizerStartResize\n')
--
-- -- vim-easy-align
map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')
--
-- -- jk escape
map({ 'i', 'n', 'v' }, 'jk', '<Esc>')
--
-- -- Window navigation (overrides ALE <C-j>/<C-k> above, same as original)
-- map('n', '<C-h>', '<C-w>h')
-- map('n', '<C-j>', '<C-w>j')
-- map('n', '<C-k>', '<C-w>k')
-- map('n', '<C-l>', '<C-w>l')
--
-- Alt word motion
map('n', '<M-f>', 'e')
map('n', '<M-b>', 'b')
--
-- -- Tab navigation
map('', '<Tab>',     'gT')
map('', '<S-Tab>',   'gt')
map('', '<leader>[', 'gt')
map('', '<leader>]', 'gT')
map('', '<leader>`', ':tabnew<CR>')

-- Method/section motions
map('n', 'd[', '[m')
map('n', 'd]', ']m')
map('n', 'c[', '[[')
map('n', 'c]', ']]')

-- Misc
map('n', '<CR>',    ':nohlsearch<CR>')
map('v', '<',       '<gv')
map('v', '>',       '>gv')
map('v', '<Tab>',   '>gv')
map('v', '<S-Tab>', '<gv')
map('c', '%%',      "<C-R>=expand('%:h').'/'<CR>")
map('v', 'J',       ":m '>+1<CR>gv=gv")
map('v', 'K',       ":m '<-2<CR>gv=gv")

-- Autocmds
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local last_pos = augroup('RememberLastPosition', { clear = true })
autocmd('BufReadPost', {
  group = last_pos,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
autocmd('BufReadPost', {
  group    = last_pos,
  pattern  = { 'COMMIT_EDITMSG', 'PULLREQ_EDITMSG' },
  callback = function() vim.api.nvim_win_set_cursor(0, { 1, 0 }) end,
})
