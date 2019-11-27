let b:current_syntax = ''
unlet b:current_syntax
syntax include @TeX syntax/tex.vim ~/.vim/after/syntax/tex

syn region markdownLatex start="\\begin{" end="\\end{" contains=@TeX keepend
syn region markdownLatex start="\$" end="\$" contains=@TeX keepend
let b:current_syntax = 'markdown'
