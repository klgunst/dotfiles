syn region texRefZone         matchgroup=texStatement start="\\auto[^{]*ref{"      end="}\|%stopzone\>"    contains=@texRefGroup
syn match texInputFile          "\\adjustimage\s*\({.\{-}}\)\{,2}"        contains=texStatement,texInputCurlies,texInputFileOpt
