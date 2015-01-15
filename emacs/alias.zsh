function emacs-debug() {
  test ! -x /Applications/Emacs.app/Contents/MacOS/Emacs && >&2 echo "cannot find emacs" && return 1
  /Applications/Emacs.app/Contents/MacOS/Emacs --debug-init $@ &
}
