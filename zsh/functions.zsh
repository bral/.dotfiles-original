function lsr () {
  clear;
  ls -oa
}

function cd () {
  builtin cd "$@";
  clear;
  lsr;
}
