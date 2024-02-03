#!/usr/bin/env bash

set -euo pipefail

cleanup() {
    rm -f "${remote_file}" "${remote_file}-run"
}

echo "${base64_encoded}" | base64 -d > "${remote_file}-run"
trap cleanup EXIT
chmod +x "${remote_file}-run"
"${remote_file}-run"
