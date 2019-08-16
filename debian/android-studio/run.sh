#!/usr/bin/env bash
# (c) alexander noehrer

function .runAndroidStudio() {
	exec /opt/android-studio/bin/studio.sh ${@} || exec bash ${@}
}

.runAndroidStudio "${@}"
