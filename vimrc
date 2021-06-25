set nocompatible              " required
filetype off                  " required

" " set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

call plug#begin('~/.local/share/nvim/plugged')

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plug 'editorconfig/editorconfig-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'slim-template/vim-slim'
Plug 'prettier/vim-prettier'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/localvimrc'
Plug 'mxw/vim-jsx'
Plug 'suan/vim-instant-markdown'
Plug 'junegunn/goyo.vim'

" Jinja2 syntax highlighting - configured to run on tera template files
Plug 'glench/vim-jinja2-syntax'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/webapi-vim'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" LanguageClient enhancements
" " Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

if !has('gui_running')
  set t_Co=256
endif

" <Leader>s for Rg search
nnoremap <C-p> :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                              'options': '--tiebreak=index'}, <bang>0)

" ...

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

" ensure utf-8 encoding
set encoding=utf-8

" automatically wrap text at 80 characters
set textwidth=80

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" more natural split opening
set splitbelow
set splitright

" enable matchit
runtime macros/matchit.vim

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" See docstrings for folded code
let g:SimpylFold_docstring_preview=1

" Set python indention based on PEP 8
" au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix

" Set js, json, html and css indention to 2 spaces
filetype plugin indent on
autocmd FileType html setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype jsx setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype rb setlocal ts=2 sw=2 expandtab
autocmd Filetype rust setlocal ts=4 sw=4 expandtab
autocmd Filetype rs setlocal ts=4 sw=4 expandtab


" Set jinja2 syntax highlighting to effect tera template files
autocmd BufNewFile,BufRead *.tera set ft=jinja

" " Autoclose completion window when done with it
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
" EOF

" Make python code pretty
" let python_highlight_all=1
" syntax on

" Relative number in normal, regular number in insert mode
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  autocmd CmdwinEnter * set norelativenumber
augroup END

" Change <Leader> to a comma and set timeout longer
let mapleader=","
let maplocalleader=","
set timeout timeoutlen=1000

" Add syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1

" Bind functions for js-beautify 
nnoremap <Leader>ff :%!js-beautify -j -s 2 -q -B -f -<CR>

" Move lines in normal or insert mode by Alt-j (down) or Alt-j (up).
" In visual mode move whole blocks with same command
nnoremap <S-j> :m+ <CR>
nnoremap <S-k> :m-2 <CR>
vnoremap <S-j> :m'>+1 <CR>gv=gv
vnoremap <S-k> :m'<-2 <CR>gv=gv 

" Mapping to automatically close (, [, or { and <C-l> to escape and
" start typing after the closing character

inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap {<CR> {<CR>}<Esc>ko
imap <C-l> <Esc>:exec "normal f" . leavechar<CR>a

" Map for copy to clipboard
noremap <Leader>y "*y
noremap <Leader>y "+y

" Toggle NerdTree (directory) Plugin Pane
nmap <C-b> :NERDTreeToggle<CR>

" Allow modifying files with NerdTree Plug
set modifiable

" Set handleChange map to autocomplete for react sessions 
" since we always do the same thing everytime
nnoremap <Leader>hc ohandleChange = evt => {<CR>}<Esc>kothis.setState({<CR>});<Esc>ko[evt.target.name]: evt.target.value 

" Tab Navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Linter
let g:ale_sign_column_always = 1

" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1

function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction

" CoC stuff
nmap <silent> gd :call <SID>GoToDefinition()<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" racer + rust
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Completion
set completeopt=noinsert,menuone,noselect
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Lightline
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/go/bin")

" Rusty-Tags support
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

highlight CocFloating ctermbg=000000
" highlight PmenuSel ctermbg=000000
" highlight PmenuSbar ctermbg=000000
" highlight PmenuThumb ctermbg=000000

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
