#!/usr/bin/env bash
# (c) alexander noehrer
set -e

function .create-template() {
	local TEMPLATE_FILE_NAME="template-eclipse.sh"
	local ENVIRONMENT_FILE_DIR="${HOME}/.env"
	local TEMPLATE_FILE_DIR="/opt/.run"
	local TEMPLATE_FILE="${ENVIRONMENT_FILE_DIR}/${TEMPLATE_FILE_NAME}"
	if [ ! -f "${TEMPLATE_FILE}" ]; then
		printf "creating '${TEMPLATE_FILE}'...\n"
		mkdir "${ENVIRONMENT_FILE_DIR}"
		cp -v "${TEMPLATE_FILE_DIR}/${TEMPLATE_FILE_NAME}" "${TEMPLATE_FILE}"
		printf "creating '${TEMPLATE_FILE}' done.\n"
	fi
}

function .run() {
	local ENVIRONMENT_FILE="${HOME}/.env/environment.sh"
	local TEMPLATE_FILE="${HOME}/.env/template.sh"
	local RUN_SCRIPT="/opt/.run/run.sh"
	local FILE

	if [ -f "${ENVIRONMENT_FILE}" ]; then
		FILE="${ENVIRONMENT_FILE}"
	elif [ -f "${TEMPLATE_FILE}" ]; then
		FILE="${TEMPLATE_FILE}"
	else
		printf "ERROR no environment file found!\n"
		return 1
	fi

	source "${FILE}"
	if [ -f "${RUN_SCRIPT}" ]; then
		bash -c "${RUN_SCRIPT}"
	else
		printf "WARN '${RUN_SCRIPT}' not found, starting bash...\n"
		bash
	fi
}

printf "\nenvironment variables:\n"
printenv
printf "\nstarting ${1}...\n"
if [ "${1}" = "${EXECUTABLE}" ]; then
	.create-template
	.run
else
	printf "starting bash...\n"
	bash
fi
