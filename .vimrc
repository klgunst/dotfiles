syntax on
filetype indent plugin on

set modeline
set background=dark
set number
set relativenumber
set shiftwidth=4

let mapleader = "-"
let maplocalleader = "\\"

"For trailing whitespace. This prevents overwriting when loading a new
"colorscheme
augroup trailwhite
  autocmd!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup END

"buffer switching without save
set hidden

"spelling
set spelllang=en_us
nnoremap <leader>sn :setlocal spelllang=nl<cr>:setlocal spell<cr>
nnoremap <leader>se :setlocal spelllang=en_us<cr>:setlocal spell<cr>

"more natural splitting
set splitbelow
set splitright

call plug#begin('$HOME/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'abudden/taghighlight-automirror'
Plug 'lervag/vimtex'
Plug 'ervandew/supertab'
Plug 'morhetz/gruvbox'
Plug 'haya14busa/vim-gtrans'
Plug 'junegunn/fzf'
Plug 'vim-syntastic/syntastic'
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'papis/papis-vim'
call plug#end()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ["flake8"]

"Colorscheme
let g:gruvbox_italic=0
colorscheme gruvbox
hi Comment ctermfg=81

hi Folded guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
set colorcolumn=79
highlight ColorColumn ctermbg=darkgrey

"include dictionaries
au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
set complete+=k

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
augroup foldrestore
    autocmd!
    "set fold method to manual when in insert
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    "set fold method to previous fold method again
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END

" MAPPINGS
nnoremap <space> za
vnoremap <space> zf
noremap L $
noremap H ^
" Maybe generalise that these work for [] and {} and \"" with same mapping
onoremap p i(
onoremap in( :<c-u>execute "normal! /(\rvi("<cr>
onoremap il( :<c-u>execute "normal! ?)\rvi("<cr>
vnoremap <buffer> _( <Esc>`>a)<Esc>`<i(<Esc>

" forget old mappings can be deleted once used to L and H
noremap ^ <nop>
noremap $ <nop>

"for editing vimrc from vim
"<cr> is carriage return or Enter
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

augroup ftplugins
    autocmd!
    autocmd BufRead,BufNewFile * nnoremap <buffer> <localleader>ev :exec('sp $HOME/.vim/ftplugin/' . &ft . '.vim')<cr>
augroup END

"alt key (is equal to escape key in terminal apparently) alt key is \e
"remaps alt+] to right one
execute "set <M-]>=\e]"

"ctags modifications
"ctrl + \ opens tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"alt + ] opens tag in horizontal split
map <M-]> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"remapping F5 for buffer menu
nnoremap <F5> :buffers<CR>:edit<space>#

"For splits
"Remapping navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
