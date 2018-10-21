" INIT
" ====================

execute pathogen#infect()

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

set completeopt=longest,menuone
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

map <SPACE> <leader>
map <leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>x :x
map <leader>q :q
map <leader>w :w



" PLUGIN 
" ================

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

hi clear ALEErrorSign
hi clear ALEWarningSign
hi ALEErrorSign guifg=#C5735E
hi ALEWarningSign guifg=#FFAF00

" Command-T
if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
endif


" LANGUAGES 
" ==================

" SQL
let g:sql_type_default = 'pgsql'

" Elm
let g:elm_setup_keybindings = 0

" Ruby
let g:ruby_host_prog = '~/.gem/ruby/2.5.0/bin/neovim-ruby-host'


