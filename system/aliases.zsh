# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# navigation
alias l="clear && ls -oa "
alias er="clear && tree .. -L 3 -I 'node_moduels|components|build|target' --filelimit 12"
alias c="clear; cd ./$1 && ls -oa"
alias j=".. && l"
alias k="- && l"

