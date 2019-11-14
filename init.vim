" INIT
" ====================

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'ajh17/Spacegray.vim'
  Plug 'jonhoo/ale', {
  \  'branch': 'rust-analyzer'
  \}
  Plug 'ElmCast/elm-vim'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'janko/vim-test'
  Plug 'jiangmiao/auto-pairs'
  Plug 'jparise/vim-graphql'
  Plug 'junegunn/fzf.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mattn/emmet-vim'
  Plug 'mxw/vim-jsx'
  Plug 'lifepillar/pgsql.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'Shougo/deoplete.nvim', {
  \  'do': ':UpdateRemotePlugins'
  \}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
call plug#end()

" THEME
" =====================
filetype plugin indent on
syntax on

colorscheme spacegray

hi SignColumn guibg=Background
hi VertSplit guibg=Background
hi NonText guifg=Background

" black
let g:terminal_color_0='#2C2F33'
let g:terminal_color_8='#4B5056'

" red
let g:terminal_color_1='#B04C50'
let g:terminal_color_9='#B04C50'

" green
let g:terminal_color_2='#919652'
let g:terminal_color_10='#94985B'

" yellow
let g:terminal_color_3='#E2995C'
let g:terminal_color_11='#E2995C'

" blue
let g:terminal_color_4='#66899D'
let g:terminal_color_12='#66899D'

" magenta
let g:terminal_color_5='#8D6494'
let g:terminal_color_13='#8D6494'

" cyan
let g:terminal_color_6='#527C77'
let g:terminal_color_14='#527C77'


" CORE 
" =====================

set backupcopy=yes
set completeopt=longest,menuone,noinsert
set expandtab
set fillchars+=vert:\|
set hidden
set nowrap
set number
set relativenumber
set scrolloff=3
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
set wildmode=list,longest,full
set wildmenu
set wildoptions+=pum

" KEYMAPS
" ===============

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
map ; :
noremap ;; ;
map <C-h> :e #<CR>
map <C-l> :nohl<CR>
map <Space> <leader>
map <leader>r :%s/
map <leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>ss :source ~/.config/nvim/sessions/Session.vim<CR>
map <leader>x :x<CR>
map <leader>q :q<CR>
map <leader>w :w<CR>
map <leader>d :!<Space>
map <leader>e :e<Space>
map <leader>c :cd<Space>
map <silent> <leader>ff :Rg<Space>
map <silent> <leader>f :Lines<CR>
map <silent> <leader>t :Files<CR>
map <silent> <leader>b :Buffers<CR>
map <silent> <leader>h :History:<CR>
nmap <leader>aj :ALENext<CR>
nmap <leader>ak :ALEPrevious<CR>
nmap <leader>ad :ALEDetail<CR>
nmap <leader>ah :ALEHover<CR>
nmap <leader>ai :ALEInfo<CR>
nmap <leader>ag :ALEGoToDefinition<CR>
nmap <leader>af :ALEFindReferences<CR>
nnoremap <silent> <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nmap <silent> <C-n> :TestNearest<CR>
nmap <C-s> :mks! ~/.config/nvim/sessions/Session.vim<CR>


" PLUGINS
" ================

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\  'auto_complete_delay': 50,
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
\   'typescript': ['eslint', 'tsserver'],
\   'python': ['flake8', 'pyls'],
\   'rust': ['rls'],
\   'yaml': ['prettier'],
\}

let g:ale_fixers = {
\   'elm': ['format'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'python': ['yapf'],
\   'rust': ['rustfmt'],
\   'yaml': ['prettier'],
\}

let g:ale_pattern_options = {
\   '.*\amp.html$': {'ale_enabled': 0},
\   '.*\Tiltfile$': {'ale_enabled': 0},
\}

let g:ale_python_flake8_options = '--ignore E501'
let g:ale_rust_rls_config = {'rust': {'clippy_preference': 'on'}}
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_warning = "●"

hi clear ALEErrorSign
hi clear ALEWarningSign
hi ALEErrorSign guifg=#C5735E
hi ALEWarningSign guifg=#FFAF00
hi ALEError guisp=#C5735E gui=undercurl
hi ALEWarn guisp=#FFAF00 gui=undercurl
hi ALEInfo guibg=#353534

" Lightline
let g:lightline = {
\'component_function': {
\    'filename': 'LightLineFilename'
\  }
\}

function! LightLineFilename() 
  let parent = split(expand('%:p:h'), '/')[-1]
  let child = expand('%:t')

  return child ==# '' ? '[No Name]' : join([parent, child], '/')
endfunction

" FZF
let $FZF_DEFAULT_COMMAND = 'fd --type f'

" LANGUAGES 
" ==================

" Elm
let g:elm_setup_keybindings = 0

" SQL
let g:sql_type_default = 'pgsql'

" Markdown
let g:markdown_fenced_languages = ['python', 'ruby', 'javascript', 'bash=sh']
let g:markdown_syntax_conceal = 0

" TESTING
" ==================

let test#strategy = 'neovim'
