if [[ `node -v` =~ ^v0.11 ]]; then
  alias node="node --harmony-generators"
  alias node-dev="node-dev --harmony-generators"
fi
