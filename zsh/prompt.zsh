autoload colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Show dirty if files modified or untracked files added
git_dirty() {
  st=`$git status 2>/dev/null | tail -n 1`
  if [[ $st == "" ]]
  then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    if [[ "$st" =~ ^nothing && "$st" =~ clean ]]; then
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    else
      echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    fi
  fi
}

# cloud symbol (in hex)
cloud() {
  echo "%{\xe2\x98\x81%G%}"
}

# nuclear symbol (in hex)
nuclear() {
  echo "%{\xe2\x98\xa2%G%}"
}

# Prompt
PRE_PROMT=
PROMPT="%{$fg[blue]%}%~ $(git_prompt_info)
%{$fg[white]%}λ %{$reset_color%}: "


# Right Prompt
RPROMPT='%{$fg_bold[black]%}%n@%m%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[lightGrey]%} $(nuclear)"
ZSH_THEME_GIT_PROMPT_CLEAN=""

