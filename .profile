export PATH=$PATH:$HOME/go/bin:$HOME/.local/bin:$HOME/.local/bin/myscripts:/opt/VESTA
export PYTHONPATH=/opt/pyscf:$PYTHONPATH
export NO_AT_BRIDGE=1 #suppresses evince warnings
export BROWSER='qutebrowser'
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# For google translate
export GOOGLE_TRANSLATE_LANG=nl
export GOOGLE_TRANSLATE_SECOND_LANG=en

# API_KEY for google translate and other things
[ -f ~/.secrets ] && source ~/.secrets
