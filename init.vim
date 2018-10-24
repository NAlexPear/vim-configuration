" INIT
" ====================

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'ajh17/Spacegray.vim'
  Plug 'autozimu/LanguageClient-neovim', {
  \  'branch': 'next',
  \  'do': 'bash install.sh',
  \}
  Plug 'itchyny/lightline.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'pangloss/vim-javascript'
  Plug 'mattn/emmet-vim'
  Plug 'mxw/vim-jsx'
  Plug 'lifepillar/pgsql.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'Shougo/deoplete.nvim', {
  \  'do': ':UpdateRemotePlugins'
  \}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'wincent/command-t'
  Plug 'w0rp/ale'
call plug#end()

" THEME
" =====================

filetype plugin indent on
syntax on

colorscheme spacegray

hi SignColumn guibg=Background
hi VertSplit guibg=Background
hi NonText guifg=Background


" CORE 
" =====================

set completeopt=longest,menuone,noinsert
set expandtab
set fillchars+=vert:\|
set grepformat^=%f:%l:%c:%m
set grepprg=rg\ -S\ --vimgrep
set hidden
set nowrap
set number
set relativenumber
set shell=zsh
set shiftwidth=2
set showmatch
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set termguicolors
set ttimeoutlen=50
set wildignorecase
set wildmode=list:longest

" KEYMAPS
" ===============

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
map <SPACE> <leader>
map <leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>x :x
map <leader>q :q
map <leader>w :w
nmap <leader>aj :ALENext<CR>
nmap <leader>ak :ALEPrevious<CR>


" Language Servers
" ================

set completefunc=LanguageClient#complete

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
\  'rust': ['rustup', 'run', 'nightly', 'rls'],
\  'javascript': ['typescript-language-server', '--stdio'],
\  'javascript.jsx': ['typescript-language-server', '--stdio'],
\}



" PLUGINS
" ================

" Deoplete

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\  'auto_complete_delay': 0,
\})

" Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" ALE
let g:ale_linters = {
\   'javascript': ['eslint', 'tsserver'],
\   'python': ['flake8'],
\   'rust': ['rustc'],
\}

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['autopep8'],
\   'rust': ['rustfmt'],
\}

let g:ale_pattern_options = {
\   '.*\amp.html$': {'ale_enabled': 0},
\}

let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_sign_warning = "●"

hi clear ALEErrorSign
hi clear ALEWarningSign
hi ALEErrorSign guifg=#C5735E
hi ALEWarningSign guifg=#FFAF00

" Command-T
if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
endif


" Lightline
let g:lightline = {
\'component_function': {
\    'filename': 'LightLineFilename'
\  }
\}

function! LightLineFilename()
  let parent = split(expand('%:p:h'), '/')[-1]

  return join([parent, expand('%:t')], '/')
endfunction


" LANGUAGES 
" ==================

" Elm
let g:elm_setup_keybindings = 0

" Ruby
let g:ruby_host_prog = '~/.gem/ruby/2.5.0/bin/neovim-ruby-host'

" SQL
let g:sql_type_default = 'pgsql'



