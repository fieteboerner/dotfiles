#!/bin/zsh

load-nvm() {
    [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh --no-use # this is really slow

    if [ "$(nvm current)" = "none" ]; then
        nvm use default >/dev/null
    fi
}

nvm() {
    unset -f nvm
    load-nvm
    nvm "$@"
}

node() {
    unset -f node
    load-nvm
    node "$@"
}

npm() {
    unset -f npm
    load-nvm
    npm "$@"
}

pnpm() {
    unset -f pnpm
    load-nvm
    pnpm "$@"
}

yarn() {
    unset -f yarn
    load-nvm
    yarn "$@"
}
