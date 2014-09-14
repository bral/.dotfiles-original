
alias tma='tmux attach -t'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'
alias tmka='tmux kill-server'

function tmn(){
  local project=`find ~/Projects -maxdepth 2 -type d -name $1`

  if [ $project ]; then
    cd $project
    tmux new-session -s `basename $project` -A
  else
    tmux new-session -s $1 -A
  fi
}

alias et="vim ~/.tmux.conf"
