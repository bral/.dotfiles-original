
function mg () {
  if [ -d .mon ]
  then
    mongroup --config .mon/mongroup.conf $@
  else
    mongroup $@
  fi
}

function wa () {
  # show cursor on exit
  trap "printf \"\033[?25h\"" 2
  # continually clear screen and hide cursor while running $1
  watcher "clear; printf \"\033[?25l\"; $1"
}

function mgw () {
  wa "mongroup --config ./.mon/mongroup.conf status"
}

alias mgr='mg start'
alias mgs='mg status'
alias mgk='mg stop'
alias mgl='mg logf'
