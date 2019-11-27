"For yaml in markdown
syn include @Yaml syntax/yaml.vim
syn region Comment start="\%^---$" end="^\(---\|\.\.\.\)$" contains=@Yaml
unlet! b:current_syntax

"For latex in markdown
syntax include @TeX syntax/tex.vim ~/.vim/after/syntax/tex
syn region markdownLatex start="\\begin{" end="\\end{" contains=@TeX keepend
syn region markdownLatex start="\$" end="\$" contains=@TeX keepend
unlet! b:current_syntax

let b:current_syntax = 'markdown'
