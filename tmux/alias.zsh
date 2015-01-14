alias tma='tmux attach -t'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'
alias tmka='tmux kill-server'

tmn() {
  local dir=$(
  find_project \
    ~/Projects 2 $1 \
    ~/.dotfiles 1 $1 \
    ~ 1 $1 \
    ~ 2 $1
  )

  if [ -z $dir ]; then
    tmux_start_session ~/Projects
  else
    tmux_start_session $dir
  fi
}

tmux_start_session() {
  local dir=$1
  vared -p "path: " dir
  test $? -gt 0 && return 1

  local safename=`echo $dir | tr -d '.' | xargs basename`
  vared -p "name: " safename
  test $? -gt 0 && return 1

  if [[ ! -d $dir ]]; then
    echo "creating $dir..."
    mkdir -p $dir
  fi

  cd $dir
  tmux new-session -A -s $safename
}

find_project() {
  local directory=$1
  local depth=$2
  local query=$3

  find $directory -maxdepth $depth -type d -name $query | read -r project

  if [ ! -z $project ]; then
    echo $project
    exit
  fi

  if [ $# -gt 3 ]; then
    shift 3
    find_project $@
  else
    >&2 echo "no projects found"
    exit 1
  fi
}

alias et="vim ~/.tmux.conf"
