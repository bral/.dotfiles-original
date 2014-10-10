
alias _node="/usr/local/bin/node"

if [[ `node -v` =~ ^v0.11 ]]; then
  alias _node="/usr/local/bin/node --harmony"
fi

if (( $+commands[node] )); then
  npm install -g nr;
fi

function node(){
  if [[ $# == 0 ]]; then
    nr;
  else
    _node $@
  fi
}
