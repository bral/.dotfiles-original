if [[ `node -v` =~ ^v0.11 ]]; then
  alias node="node --harmony"
  alias node-dev="node-dev --harmony"
fi
