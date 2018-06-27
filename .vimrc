syntax on
filetype indent plugin on

set modeline
set background=dark
set number
set relativenumber
set shiftwidth=4

call plug#begin('$HOME/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'abudden/taghighlight-automirror'
Plug 'christoomey/vim-tmux-navigator'
Plug 'LaTex-Box-Team/LaTeX-Box'
Plug 'ervandew/supertab'
Plug 'morhetz/gruvbox'
Plug 'haya14busa/vim-gtrans'
call plug#end()

"Colorscheme
let g:gruvbox_italic=1
colorscheme gruvbox
"colorscheme industry
hi Comment ctermfg=81
hi Folded guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE

set colorcolumn=100
highlight ColorColumn ctermbg=darkgrey

nnoremap <space> za
vnoremap <space> zf

"alt key (is equal to escape key in terminal apparently) alt key is \e
"remaps alt+] to right one
"execute "set <M-]>=\e]"

"ctags modifications
"ctrl + \ opens tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"ctrl + ] opens tag in vertical split
map <M-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"buffer switching without save
set hidden

"remapping F5 for buffer menu
nnoremap <F5> :buffers<CR>:edit<space>#

"include dictionaries
au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
set complete+=k

"highlight cursor with \c
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"spelling
set spelllang=en_us

"for latex, .tex files are standard latex and not plaintex for example
let g:tex_flavor = "latex"
let g:LatexBox_viewer = "evince"

"for .docx files, read through pandoc to markdown format
autocmd BufReadPost *.docx :%!pandoc -f docx -t markdown
autocmd BufWritePost *.docx :!pandoc -f markdown -t docx % > tmp.docx

autocmd BufReadPost *.odt :%!pandoc -f odt -t markdown
autocmd BufWritePost *.odt :!pandoc -f markdown -t odt % > tmp.odt

"For neomutt
au BufRead /tmp/neomutt-* set tw=80
au BufRead /tmp/neomutt-* set colorcolumn=80
au BufRead /tmp/neomutt-* set spell
