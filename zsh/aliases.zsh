# -*- mode: sh -*-

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
alias l="clear && lsr"
alias er="clear && tree -L 3 -I 'node_moduels|components|build|target' -C"
alias j="cd .."
alias k="cd -"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# make mv ask before overwriting a file by default
alias mv='mv -i'

# misc
alias fs="foreman start"
alias terminal-notifier="/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier"
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"
alias wp="webpack"
