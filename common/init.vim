" VIM-PLUG

call plug#begin()
"--------------------------------- TOOLS
Plug 'scrooloose/nerdtree'      "Directory Explorer
Plug 'scrooloose/nerdcommenter' "Commenting Tool
"Plug 'w0rp/ale'                 "Linting
Plug 'kien/ctrlp.vim'           "File Search

"Plug 'junegunn/goyo.vim'        "Focus Mode
"Plug 'junegunn/limelight.vim'   "Block-Scoped Highlighting
"Plug 'elentok/plaintasks.vim'   "TEST: .todo format

"--------------------------------- SYNTAX
"Plug 'rhysd/vim-crystal'
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
"Plug 'ElmCast/elm-vim'
Plug 'tidalcycles/vim-tidal'

syntax on
filetype plugin indent on

"--------------------------------- COLOR
Plug 'flazz/vim-colorschemes'
Plug 'xero/sourcerer.vim'
Plug 'xero/blaquemagick.vim'
Plug 'nightsense/carbonized'

call plug#end()


"--------------------------------- EDITOR
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2




"colorscheme znake "haskell
"colorscheme maui  "haskell
colorscheme mustang "default
"colorscheme gruvbox
"colorscheme lucid   "default alt


"Nerdtree
let g:NERDTreeWinPos = "right"

"Keymaps
map      <C-b>   :NERDTreeToggle<CR>
map      <C-r>     :source $MYVIMRC<CR>
"map      <C-b>     :!make<CR>
" Prev and next sections (tidal)
map      <C-j>   /--\_s@<CR>
map      <C-k>   ?--\_s@<CR>


"nnoremap <C-f>     :Goyo<CR>
"nnoremap <C-\>     :TagbarToggle<CR>
nnoremap <C-C>     :colorscheme 
nnoremap <C-Space> :vs $MYVIMRC<CR>

"Tidal Config
let g:tidal_target = "terminal"

map      <C-Enter>   :TidalSend<CR>
map      <C-S-Enter>   :TidalSend<CR>

"Tidal Syntax
au BufRead,BufNewFile *.tidal set filetype=haskell
au BufRead,BufNewFile *.tidal set ft=tidal
