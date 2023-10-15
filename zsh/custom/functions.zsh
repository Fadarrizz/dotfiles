function gcop() {
  git checkout "$1" && git pull
}

function gcobo() {
  git checkout "$1" && git pull
  git checkout -b "$2"
}

function md {
    mkdir -p "$1" ; cd "$1"
}

function pd {
    pushd "$@" > /dev/null
}

function back {
    popd > /dev/null
}

function addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

function addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}
