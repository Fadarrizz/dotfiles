#!/bin/bash

# Generates/updates $HOME/.gradle/gradle.properties with Artifactory
# credentials (artifactory_user and artifactory_key), prompting the user
# for both values. If the file already exists, matching keys are updated
# in place and missing keys are appended.

set -e

GRADLE_DIR="${HOME}/.gradle"
GRADLE_PROPERTIES="${GRADLE_DIR}/gradle.properties"

mkdir -p "${GRADLE_DIR}"
touch "${GRADLE_PROPERTIES}"

read -rp "Glovo email (artifactory_user): " ARTIFACTORY_USER
read -rp "Artifactory personal key (artifactory_key): " ARTIFACTORY_KEY

set_property() {
	local key="$1"
	local value="$2"
	local file="$3"

	if grep -q "^${key}=" "${file}"; then
		sed -i '' "s|^${key}=.*|${key}=${value}|" "${file}"
	else
		printf '%s=%s\n' "${key}" "${value}" >> "${file}"
	fi
}

set_property "artifactory_user" "${ARTIFACTORY_USER}" "${GRADLE_PROPERTIES}"
set_property "artifactory_key" "${ARTIFACTORY_KEY}" "${GRADLE_PROPERTIES}"

echo "Updated ${GRADLE_PROPERTIES}"
