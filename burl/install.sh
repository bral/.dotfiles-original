# Install burl

if test ! (( $+command[burl] )); then
  mkdir /tmp/burl && cd /tmp/burl && curl -L# https://github.com/visionmedia/burl/archive/master.tar.gz | tar zx --strip 1 && make install
fi
