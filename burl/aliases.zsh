
alias HEAD='burl -I'
alias POST='burl POST'
alias PUT='burl PUT'
alias PATCH='burl PATCH'
alias DELETE='burl DELETE'
alias OPTIONS='burl OPTIONS'

function GET() {
  if [[ $# == 0 ]]; then
    burl GET "$BURL"
    return 0
  fi
  burl GET $@
}
