alias rehash='hash -r'
alias reload!='. ~/.zshrc'
alias cdot='cd ~/.dotfiles'
alias cproj='cd ~/Projects'
alias proj='cd ~/Projects'
alias dot='~/.dotfiles/install'

# dotfiles
alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"

# movement
alias l="lsr"
alias er="clear && tree .. -L 3 -I 'node_moduels|components|build|target' --filelimit 12 -C"
alias j="cd .."
alias k="cd -"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# misc
alias fs="foreman start"
alias add-path="PATH=$PATH:`pwd`"
