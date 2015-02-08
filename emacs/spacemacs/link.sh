#!/usr/local/bin/zsh

TARGET=~/.emacs.d
SOURCE=~/.dotfiles/emacs
COMMON=$SOURCE/emacs.d.symlink
SPACEMACS=$SOURCE/spacemacs

mkdir -p \
  $TARGET/eshell \
  $TARGET/.cache

ln -s $COMMON/eshell/alias $TARGET/eshell/alias 2 &>/dev/null
ln -s $SPACEMACS/spacemacs.symlink ~/.spacemacs 2 &>/dev/null
ln -fs $SPACEMACS/extensions/yasnippet-snippets snippets

# use our banners instead
rm $TARGET/core/banners/*
for b in $(ls banners); do
  ln -fs $SPACEMACS/banners/$b ~/.emacs.d/core/banners/$b
done
