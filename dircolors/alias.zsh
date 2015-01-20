
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    LSCOLORS=eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
fi

# LSCOLORS/LS_COLORS
autoload colors; colors;

# Do we need Linux or BSD Style?
if ls --color -d . &>/dev/null 2>&1
then
  # Linux Style
  export LS_COLORS=$LS_COLORS
  alias ls='ls --color=tty'
else
  # BSD Style
  export LSCOLORS=$LSCOLORS
  alias ls='ls -G'
fi

# Use same colors for autocompletion
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
