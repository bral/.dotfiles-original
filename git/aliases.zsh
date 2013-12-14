# Use `hub` as wrapper
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias gd="git diff | subl"
alias ga="git add"
alias gbd="git branch -D"
alias gs="git status"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gm="git merge --no-ff"
alias gpt="git push --tags"
alias gp="git push"
alias grh="git reset --hard"
alias gb="git branch"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gcp="git cherry-pick"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gpom="git pull origin master"
alias gpo="git pull origin"
alias gcd='cd "`git rev-parse --show-toplevel`"'
