# Install git-extras

if test ! $(which git-extras); then
  (cd /tmp && git clone --depth 1 https://github.com/visionmedia/git-extras.git && cd git-extras && sudo make install)
fi
