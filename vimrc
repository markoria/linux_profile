set nocompatible
set t_Co=256
syntax enable
colorscheme molokai

autocmd BufRead,BufNewFile *.json set filetype=json
autocmd Syntax json sou ~/.vim/syntax/json.vim

if exists('+colorcolumn')
  set colorcolumn=81
  highlight ColorColumn ctermbg=red
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

set number
set numberwidth=6
set cul
set laststatus=2
set nohlsearch
set incsearch
set ignorecase
set ruler
set showmatch
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set visualbell

set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set smarttab
set nowrap


command PrettyJSON %!python -m json.tool