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
alias gcb="git checkout -b"
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

function grao() {
  if [[ -z $argv ]]; then
    local repo=$(pwd | sed -E "s,(.+)(Projects/),,")
    local url="https://github.com/$repo.git"
    echo "adding remote $url"
    git remote add origin $url
  else
    local repo=$0/$1
    local url="https://github.com/$repo.git"
    echo "adding remote $url"
    git remote add origin $url
  fi
}

function grro() {
  if [[ -z $argv ]]; then
    git remote remove origin
  else
    git remote remove origin $argv
  fi
}

function gsll() {
  for i in `find . -name .git -depth 2 | xargs -n1 dirname`
  do
    pushd $i > /dev/null
    if [ -n "$(git status --porcelain)" ]; then
      echo $i
      git status -s
      printf "\n"
    fi
    popd > /dev/null
  done
}
