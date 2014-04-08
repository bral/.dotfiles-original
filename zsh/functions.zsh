
function lsr () {
  clear;
  gls  \
    -go \
    -l \
    --almost-all \
    --human-readable \
    --color=auto \
    --group-directories-first \
    --ignore="#*" \
    --ignore=".DS_Store" \
    --ignore="*~"
}

function cd () {
  builtin cd "$@";
  clear;
  lsr;
  if [ ! -z $TMUX ]; then
    set-window-title "`basename $PWD`"
  else
    set-tab-title "`basename $PWD`"
  fi
}

function set-tab-title {
  local title_format{,ted}
  zstyle -s ':prezto:module:terminal:tab-title' format 'title_format' || title_format="%s"
  zformat -f title_formatted "$title_format" "s:$argv"

  printf "\e]1;%s\a" ${(V%)title_formatted}
}

function set-window-title {
  local title_format{,ted}
  zstyle -s ':prezto:module:terminal:window-title' format 'title_format' || title_format="%s"
  zformat -f title_formatted "$title_format" "s:$argv"

  if [[ "$TERM" == screen* ]]; then
    title_format="\ek%s\e\\"
  else
    title_format="\e]2;%s\a"
  fi

  printf "$title_format" "${(V%)title_formatted}"
}
