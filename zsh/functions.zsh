function lsr () {
  clear;
  ls -oa
}

function cd () {
  builtin cd "$@";
  clear;
  lsr;
  set-tab-title "`basename $PWD`"
}

function set-tab-title {
  local title_format{,ted}
  zstyle -s ':prezto:module:terminal:tab-title' format 'title_format' || title_format="%s"
  zformat -f title_formatted "$title_format" "s:$argv"

  printf "\e]1;%s\a" ${(V%)title_formatted}
}
