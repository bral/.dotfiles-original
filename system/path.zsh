## Export PATH
export PATH=/usr/local/opt/ruby/bin:/usr/local/bin:$HOME/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Spot for gems
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem

# Default cd path for interactive shells
if test “${PS1+set}”; then
  CDPATH=:"..:~:~/Projects";
fi
