#!/bin/bash

# Regenerates npm/.npmrc from npm/.npmrc.template by resolving Proton Pass
# secret references (pass://vault/item/field). Requires an authenticated
# pass-cli session (run `pass-cli login` once if needed).

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v pass-cli > /dev/null 2>&1; then
	echo "pass-cli not found, skipping .npmrc generation. Install with: brew bundle"
	exit 0
fi

if ! pass-cli info > /dev/null 2>&1; then
	echo "Log in to Proton Pass to generate npm/.npmrc..."
	pass-cli login
fi

pass-cli inject \
	--in-file "${BASEDIR}/npm/.npmrc.template" \
	--out-file "${BASEDIR}/npm/.npmrc" \
	--force \
	--file-mode 0600

echo "Generated npm/.npmrc from template"
