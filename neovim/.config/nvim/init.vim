" ----- Editor Setup -----
" General Settings
" Need to know what exactly each line means
filetype plugin indent on
syntax on
set encoding=utf-8
set tabstop=2
set expandtab
set autoindent
set shiftwidth=2
set scrolloff=3
set showcmd
set hidden
set wildmenu
set visualbell
set splitbelow
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set relativenumber
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set wrap
set linebreak
set nolist
set shortmess+=c

" ----- Plugins -----
call plug#begin('~/.vim/plugged')
" themes and decoration
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
" Jump
Plug 'easymotion/vim-easymotion'
" Completion and Syntax Highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
" Diagnostics
Plug 'dense-analysis/ale'
" Git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'zivyangll/git-blame.vim'
" Tags view
Plug 'liuchengxu/vista.vim'
" Finder
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Languages
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
" Comment
Plug 'tpope/vim-commentary'
" Sinppets
Plug 'honza/vim-snippets'
call plug#end()

"-----------themes----------"
set termguicolors
colorscheme dracula
"colorscheme onedark

"----------coc plugins----------"
let g:coc_global_extensions = ["coc-css",
            \ "coc-eslint",
            \ "coc-explorer",
            \ "coc-html",
            \ "coc-json",
            \ "coc-emmet",
            \ "coc-prettier",
            \ "coc-python",
            \ "coc-tslint",
            \ "coc-tsserver",
            \ "coc-ultisnips",
            \ "coc-vetur"]

"----------coc explorer----------"
let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/Projects',
\   },
\   'floating': {
\      'position': 'floating',
\   }
\ }

:nmap <space>ed :CocCommand explorer --preset .vim<CR>
:nmap <space>ef :CocCommand explorer --preset floating<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gm <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Custom key mapping
let mapleader=' '
" 内置终端中切换模式
tnoremap <Esc> <C-\><C-n>
" 清除搜索结果高亮
noremap <C-n> :nohlsearch<CR>
" 跳转
noremap <Leader>k <C-u>
noremap <Leader>j <C-d>
noremap <Leader>h 0
noremap <Leader>l $
noremap <Leader>ww <C-w>w
noremap <Leader>wh <C-w>h
noremap <Leader>wj <C-w>j
noremap <Leader>wk <C-w>k
noremap <Leader>wl <C-w>l
" 切换Buffer
noremap <Leader>bn :bn<CR>
noremap <Leader>bp :bp<CR>
" close current buffer and auto switch to another 
noremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
" Tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Vim Easymotion
:nmap <Leader><Leader>s <Plug>(easymotion-s2)

" Vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1

" Vim Clap
noremap <Leader>fl :Clap files<CR>
noremap <Leader>bf :Clap buffers<CR>
noremap <Leader>gr :Clap grep<CR>
noremap <Leader><Leader>p :Clap<CR>

" Git blame
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

" Vista.vim
noremap <c-t> :silent! Vista coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Ale
let g:ale_set_highlights = 1
let g:ale_set_quickfix = 1
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 1

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
" nmap <Leader>l :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
let g:ale_linters = {
    \ 'go': ['golint', 'go vet', 'go fmt'],
    \ }

