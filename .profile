export PATH=$PATH:$HOME/.local/bin:/opt/VESTA:/opt/intel/vtune_amplifier/bin64:/opt/Citrix/ICAClient
export PYTHONPATH=/opt/pyscf:$PYTHONPATH
export GOPATH=$HOME/.local/go
export NO_AT_BRIDGE=1  # suppresses evince warnings
export BROWSER='firefox'
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# For google translate
export GOOGLE_TRANSLATE_LANG=nl
export GOOGLE_TRANSLATE_SECOND_LANG=en

# API_KEY for google translate and other things
[ -f ~/.secrets ] && source ~/.secrets
