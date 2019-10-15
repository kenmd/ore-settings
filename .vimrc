set showcmd
set number

set smartindent
set visualbell
set showmatch

set wildmode=list:longest
nnoremap j gj
nnoremap k gk
set list listchars=tab:\▸\-
set expandtab
set tabstop=4
set shiftwidth=4
set ignorecase
set smartcase
set incsearch
set nowrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

syntax on

set directory=/tmp

" https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim/7894493
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
