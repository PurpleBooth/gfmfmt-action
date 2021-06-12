#!/usr/bin/env bash

set -euo pipefail

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
    MESSAGE="This file is badly formatted, run \"pandoc --from=gfm --to=gfm --wrap=auto '$1'\" to fix it
$(diff "$1" "$TEMPORARY_FILE")"
    MESSAGE="${MESSAGE//'%'/'%25'}"
    MESSAGE="${MESSAGE//$'\n'/'%0A'}"
    MESSAGE="${MESSAGE//$'\r'/'%0D'}"
    echo "::error file=$1::$MESSAGE"
    echo "::group::diff"
    diff "$1" "$TEMPORARY_FILE"
    echo "::endgroup::"
    return 1
  fi
}

ARGUMENTS=("$@")
CHECK_MODE="${ARGUMENTS[0]}"
INPUT_PATHS=("${ARGUMENTS[@]:1}")
FAILURE=0
cd "${GITHUB_WORKSPACE:-.}"

for I in "${INPUT_PATHS[@]}"; do
  while read -r FILE; do
    if [ "$CHECK_MODE" = "true" ]; then
      if ! check "$FILE"; then
        FAILURE=1
        echo "☠️ Unformatted $FILE"
      fi
    else
      format "$FILE"
    fi

  done < <(compgen -G "$I" || true)
done

cd - >/dev/null

exit $FAILURE
