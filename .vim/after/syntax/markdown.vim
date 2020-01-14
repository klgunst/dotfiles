"For yaml in markdown
syn include @Yaml syntax/yaml.vim
syn region mdYaml start="\%^---$" end="^\(---\|\.\.\.\)$" contains=@Yaml fold
hi link mdYaml SpecialComment
unlet! b:current_syntax

"For latex in markdown
syntax include @TeX syntax/tex.vim ~/.vim/after/syntax/tex
syn region mdTeX start="\\begin{.\+}" end="\\end{.\+}" contains=@TeX keepend fold
syn region mdTeX start="\$" end="\$" contains=@TeX keepend fold
unlet! b:current_syntax

"For python in markdown
syntax include @Python syntax/python.vim
syn region mdPython matchgroup=markdownCode start="^```python$" end="^\(```\|\.\.\.\)$" contains=@Python fold
unlet! b:current_syntax

let b:current_syntax = 'markdown'
hi markdownItalic cterm=italic
