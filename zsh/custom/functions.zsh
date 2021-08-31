function gcop() {
  git checkout "$1" && git pull
}

function gcobo() {
  git checkout "$1" && git pull
  git checkout -b "$2"
}
