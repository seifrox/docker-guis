#!/usr/bin/env bash
# (c) alexander noehrer

function .runEclipse() {
	exec /opt/eclipse/eclipse -data "${HOME}/workspace" "${@}" || exec bash "${@}"
}

.runEclipse "${@}"
