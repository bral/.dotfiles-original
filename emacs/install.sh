#!/usr/local/bin/zsh

if test -d ~/.emacs.d; then
  answer=
  vared -p 'This will remove your current emacs.d. Continue?' answer

  if [[ ! $answer =~ ^[Yy] ]]; then return 0; fi

  mv ~/.emacs.d ~/.Trash/.emacs.d

  git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d

fi
