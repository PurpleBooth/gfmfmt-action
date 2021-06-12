#!/usr/bin/env bash

set -euo pipefail

ARGUMENTS=("$@")
CHECK_MODE="${ARGUMENTS[0]}"
INPUT_PATHS=("${ARGUMENTS[@]:1}")

function format_to_temp() {
  TEMPORARY_FILE="$(mktemp -d)/$(basename "$1")"
  pandoc --from=gfm --to=gfm --wrap=auto "$1" >"$TEMPORARY_FILE"
  echo "$TEMPORARY_FILE"
}

function format() {
  TEMPORARY_FILE="$(format_to_temp "$1")"
  mv "$TEMPORARY_FILE" "$1"
}

function check() {
  TEMPORARY_FILE="$(format_to_temp "$1")"

  if ! diff "$1" "$TEMPORARY_FILE"; then
    echo "::error file=$1::This file is badly formatted, run \"pandoc --from=gfm --to=gfm --wrap=auto \"$1\"\" to fix it"
    return 1
  fi
}

cd "${GITHUB_WORKSPACE:-.}"
FAILURE=0

for I in "${INPUT_PATHS[@]}"; do
  while read -r FILE; do
    if [ "$CHECK_MODE" = "true" ]; then
      if ! check "$FILE"; then
        FAILURE=1
      fi
    else
      format "$FILE"
    fi
  done < <(compgen -G "$I" || true)
done
cd - >/dev/null

exit $FAILURE
