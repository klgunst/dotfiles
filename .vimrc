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
Plug 'lervag/vimtex'
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

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
	let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
	let linenum = v:foldstart + 1
	while linenum < v:foldend
	    let line = getline( linenum )
	    let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
	    if comment_content != ''
		break
	    endif
	    let linenum = linenum + 1
	endwhile
	let sub = initial . ' ' . comment_content
    else
	let sub = line
	let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
	if startbrace == '{'
	    let line = getline(v:foldend)
	    let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
	    if endbrace == '}'
		let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
	    endif
	endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
endfunction

"This is to prevent that all folds open when an automatic folding method is
"used. By inserting text that start a fold, all folds beneath it would open
"otherwise.
"
"set fold method to manual when in insert
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"set fold method to previous fold method again
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

set colorcolumn=80
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

"For splits
"Remapping navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"more natural splitting
set splitbelow
set splitright
