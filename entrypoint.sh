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

{
  cd "$GITHUB_WORKSPACE"
  CHECK_MODE="$1"
  readarray -d '' INPUT_PATHS < <(find "./" -type f | grep -E "$2" | tr "\n" "\0")
  FAILURE=0

  for FILE in "${INPUT_PATHS[@]}"; do
    if [ "$CHECK_MODE" = "true" ]; then
      if ! check "$FILE"; then
        FAILURE=1
        echo -e "\e[31m☠️ $FILE is unformatted\e[0m"
      else
        echo -e "\e[32m✨ $FILE looks good\e[0m"
      fi
    else
      format "$FILE"
    fi
  done
}

exit $FAILURE
