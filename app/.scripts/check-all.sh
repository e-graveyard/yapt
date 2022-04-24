#!/usr/bin/env bash

HAS_ERR=0

update_err_flag() {
    if [ "$?" -gt 0 ]; then
        HAS_ERR=1
    fi
}

cprint() {
    python .scripts/cprint.py "$1"
    echo ""
}

poe() {
    cprint "$2 CHECK"
    poetry run poe "$1"
    update_err_flag
}

check_all() {
    # black
    poe "check:style" "CODE STYLE"

    # vulture
    poe "check:deadcode" "DEAD CODE CHECK"

    # bandit
    poe "check:security" "CODE SECURITY"

    # mypy
    poe "check:types" "STATIC TYPE"

    # pylint
    poe "check:lint" "CODE QUALITY"

    printf "\n\n"
}

check_all
exit "$HAS_ERR"
