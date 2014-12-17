# -*- mode: shell-script; -*-

alias tma='tmux attach -t'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'
alias tmka='tmux kill-server'

tmn() {

  PROJ=`tmux_project_session ~/Projects 2 $1`
  if [ $PROJ ]; then return; fi
  PROJ=`tmux_project_session ~ 1 $1`
  if [ $PROJ ]; then return; fi
  PROJ=`tmux_project_session ~ 2 $1`
  if [ $PROJ ]; then return; fi

  tmux new-session -A -s $1;
}

tmux_project_session() {
  local directory=$1
  local depth=$2
  local query=$3

  find $directory -maxdepth $depth -type d -name $query | read -r project

  if [ $project ]; then
    cd $project
    local safename=`echo $project | tr -d '.' | xargs basename`
    tmux new-session -A -s $safename
    echo
  fi
}

alias et="vim ~/.tmux.conf"
