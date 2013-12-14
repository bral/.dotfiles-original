# Install n

if test ! $(which n); then
  mkdir /tmp/n && cd /tmp/n && curl -L# https://github.com/visionmedia/n/archive/master.tar.gz | tar zx --strip 1 && make install
fi

# Install node

if test ! $(which node); then
  n latest
fi

# Install useful deps

npm install -g component
npm install -g node-dev
npm install -g serve
npm install -g ngen
npm install -g node-gyp
npm install -g mocha
