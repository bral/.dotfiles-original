
# install mon

if test ! $(which mon); then
  mkdir /tmp/n && cd /tmp/n && curl -L# https://github.com/visionmedia/mon/archive/master.tar.gz | tar zx --strip 1 && make install && rm -rf /tmp/mon
  mkdir /tmp/n && cd /tmp/n && curl -L# https://github.com/jgallen23/mongroup/archive/master.tar.gz | tar zx --strip 1 && make install && rm -rf /tmp/mongroup
fi

