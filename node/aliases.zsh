
alias _node="/usr/local/bin/node"

if [[ `node -v` =~ ^v0.11 ]]; then
  alias _node="/usr/local/bin/node --harmony"
fi

function node(){
  if [[ $# == 0 ]]; then
    nr;
  else
    _node $@
  fi
}
