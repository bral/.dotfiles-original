# -*- mode: shell-script; -*-

# Use `hub` as wrapper
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias git="noglob git"

alias ga="git add -A"
alias gb="git branch"
alias gbd="git branch -D"
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias gf="git fetch"
alias gl="git l"
alias gl="git log"
alias gp="git push"
alias gpl="git pull"
alias gpo="git pull origin"
alias gpom="git pull origin master"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gri="git rebase --interactive"
alias gs="git status"
alias gst="git stash"
alias gsh="git show"
alias gstp="git stash pop"
alias gcp="git cherry-pick"

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

function clone() {
  if [ ! -d $PROJECTS ]; then
    <&2 echo \
      "Cannot clone without PROJECTS environment variable." \
      "Export target projects directory as PROJECTS and retry."
    return 1
  fi

  PWD=$(pwd)
  DEPTH=("${(s,/,)PWD}")
  PROJECTS_DIR=$(basename $PROJECTS)
  BASE=$DEPTH[5]

  # TODO
  # check if arg1 is url for quick cloning
  # e.g. https://github.com/(org)/(repo)
  ARGS=("${(s,/,)@}")
  ORG=$ARGS[1]
  REPO=$ARGS[2]

  if [[ -e $1 ]]; then
    local answer=Y
    vared -p "$PROJECTS/$1 exists. visit? " answer
    if [[ $? -gt 0 || $answer -ne "Y" ]]; then return 1; fi
    cd $1
  else
    if [[ -z $ORG ]]; then
      <&2 echo 'Usage: [org/]<repo>'
      return 1
    elif [[ $DEPTH[4] != $PROJECTS_DIR || $#DEPTH > 5 || $#DEPTH < 3 ]]; then
      <&2 echo "you must use \`$0\` in $PROJECTS or a child directory"
      return 1
    elif [[ $1 == */* ]]; then
      if [[ $#DEPTH == 4 ]]; then
        echo "creating $ORG..."
        mkdir $ORG
        cd $ORG
      fi
      hub clone $ORG/$REPO
      cd $REPO
    else
      hub clone $BASE/$1
      cd $1
    fi
  fi

  if [[ -z $REPO ]]; then REPO=$ORG; fi

  test -z $TMUX && tmux new-session -A -s $REPO
}
