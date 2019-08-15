#!/usr/bin/env bash
# (c) alexander noehrer

function .runFreemind() {
	exec /opt/freemind/freemind.sh ${@} || exec bash ${@}
}

.runFreemind "${@}"
