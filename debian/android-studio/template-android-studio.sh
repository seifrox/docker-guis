#!/usr/bin/env bash

#create an 'environment.sh' file for customized environment variables
export DISPLAY=":1"
export EXECUTABLE="${EXECUTABLE:-"bash"}"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp -Dswing.aatext=true -Djavax.accessibility.assistive_technologies=" "'
