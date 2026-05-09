#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"

if [ ! -f "${ENV_FILE}" ]; then
  cp "${SCRIPT_DIR}/.env.example" "${ENV_FILE}"
fi

docker compose --env-file "${ENV_FILE}" -f "${SCRIPT_DIR}/compose.yaml" up -d
