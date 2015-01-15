#!/usr/local/bin/zsh

TARGET=~/.emacs.d
SOURCE=~/.dotfiles/emacs
COMMON=$SOURCE/emacs.d.symlink
SPACEMACS=$SOURCE/spacemacs

mkdir -p \
  $TARGET/eshell \
  $TARGET/.cache

cp $SPACEMACS/banner.txt $TARGET/core/banner.txt

# ln -fs $COMMON/eshell/alias $TARGET/eshell/alias

# ln -fs $SPACEMACS/spacemacs.symlink ~/.spacemacs
