# Use `hub` as wrapper
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias git="noglob git"

alias gs="git status"
alias gst="git stash"
alias gco="git checkout"
alias ga="git add -A"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gri="git rebase --interactive"
alias gl="git l"
alias gd="git diff"
alias gpl="git pull"
alias gp="git push"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gbd="git branch -D"
alias gpom="git pull origin master"
alias gpo="git pull origin"
alias gl="git log"
