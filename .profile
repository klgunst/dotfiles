export PATH=$HOME/.local/bin:/opt/VESTA:/opt/intel/vtune_amplifier/bin64
export PYTHONPATH=/opt/pyscf:$PYTHONPATH
export GOPATH=$HOME/.local/go
export BROWSER='firefox'
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# For google translate
export GOOGLE_TRANSLATE_LANG=nl
export GOOGLE_TRANSLATE_SECOND_LANG=en

# API_KEY for google translate and other things
[ -f ~/.secrets ] && source ~/.secrets
