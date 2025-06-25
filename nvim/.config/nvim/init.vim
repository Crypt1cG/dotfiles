" load plugin file
" lua require('plugins')

" main lua init thing
lua require('init')

colorscheme catppuccin-mocha

" make bg transparent (uses terminal background)
hi Normal guibg=NONE
" this is for like when you have multiple splits - inactive one
" changes color with some themes, this keeps it transparent
hi NormalNC guibg=NONE
" this seems to affect help menu and stuff
hi NormalSB guibg=NONE
" this is for nvimtree (file explorer)
hi NvimTreeNormal guibg=NONE
hi NvimTreeNormalNC guibg=NONE
hi NormalFloat guibg=NONE

" Tab setup - use tab character, visible width = 4 spaces
" Not sure if all of these are needed, copied from my vim conf
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

" keybind for nvim-tree
map <C-n> :NvimTreeToggle<CR>

" code folding
" set fdm=syntax " I guess this is for normal vim folding
" treesitter (kinda doesn't work sometimes)
"set fdm=expr 
"set foldexpr=nvim_treesitter#foldexpr()
"set nofoldenable
" just good-ol indentation
set fdm=indent

" sign coloumn is the thing on the left that shoes little error symbols and such
set signcolumn=yes " ensure it's always there, otherwise it pops in and out annoyingly
hi SignColumn guibg=NONE

" limit the height of the autocomplete window
set pumheight=10

" conceal some symbols in latex
set conceallevel=0
" use zathura for viewing pdfs from latex
let g:vimtex_view_method='zathura'
" fix highlight stuff in zathura
let g:vimtex_view_forward_search_on_start='false'

" should make it so vim stops adding newlines to the end of like every file ever
set nofixeol
