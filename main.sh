#!/bin/bash
# shellcheck disable=SC1117
#
# This is an options script used to invoke various other tools or scripts
#

# Make sure we capture failures from pipe commands
set -o pipefail

show-help () {
    echo -en "Usage: $0 [options] command\n\n"
    echo -en "Commands:\n"
    echo -en "  run-checks [cmd]    Run the run-chcks script [DEFAULT]\n"
    echo -en "  run-builds [cmd]    Run the run-builds script\n"
    echo -en "  go-build [cmd]      Run the go-make script\n"
    echo -en "Options:\n"
    echo -en "  --help       -h      Print this help information and exit\n"
    echo -en "  --setx       -x      Turn on bash setx, should be set before other arguments\n"
    echo -en "                         Basically set -x\n\n"
}

while [ "$1" != "" ]; do
    case $1 in
        -h | --help | help )
            show-help
            exit 0
        ;;
        --debug | --setx | -x )
            set -x
        ;;
        go-build )
            go-build
        ;;
        run-checks | lint )
            run-checks
        ;;
        run-builds )
            run-builds
        ;;
        * )
            show-help
        ;;
    esac
    shift
done
