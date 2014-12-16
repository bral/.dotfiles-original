#!/usr/local/bin/zsh

install_spacemacs() {
  git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d
}

if test -e ~/.emacs.d; then
  answer=
  vared -p 'This will remove your current emacs.d. Continue?' answer

  if [[ ! $answer =~ ^[Yy] ]]; then return 0; fi

  mv ~/.emacs.d ~/.Trash/.emacs.d

  install_spacemacs
else
  install_spacemacs
fi
