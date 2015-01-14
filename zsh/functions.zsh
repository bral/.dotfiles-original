# -*- mode: sh -*-

function lsr() {
  gls \
    --ignore={#*,*~,.DS_Store,.tern-port} \
    -go \
    -l \
    --almost-all \
    --human-readable \
    --group-directories-first \
    --color=always \
    --time-style='+%b-%d-%y %H:%M' \
    $@ \
      | grep -v -e '^total'
}

function cd() {
  builtin cd "$@"
  clear
  lsr
  test -f .env && source .env
  test ! -z $TMUX && set-window-title "`basename $PWD`"
  set-tab-title "`basename $PWD`"
}

function set-tab-title() {
  local title_format{,ted}
  zstyle -s ':prezto:module:terminal:tab-title' format 'title_format' || title_format="%s"
  zformat -f title_formatted "$title_format" "s:$argv"

  printf "\e]1;%s\a" ${(V%)title_formatted}
}

function set-window-title() {
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

function grep() {
  /usr/bin/grep --exclude-dir={node_modules,.git,components} $@
}
