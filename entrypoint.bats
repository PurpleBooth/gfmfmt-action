#!/usr/bin/env bats

@test "can use globbing" {
  MD_DIR="$(mktemp -d)"
  cat <<EOC > "$MD_DIR/file_one.md"
Hello World
===========
EOC
  cat <<EOC > "$MD_DIR/file_two.md"
Hello World
===========
EOC


  run ./entrypoint.sh false "$MD_DIR/file*.md"
  [ "$status" -eq 0 ]
  [ "$(cat "$MD_DIR/file_one.md")" = "# Hello World" ]
  [ "$(cat "$MD_DIR/file_two.md")" = "# Hello World" ]
}


@test "can format a file" {
  MD_FILE="$(mktemp)"
  cat <<EOC > "$MD_FILE"
Hello World
===========
EOC

  run ./entrypoint.sh false "$MD_FILE"
  [ "$status" -eq 0 ]
  [ "$(cat "$MD_FILE")" = "# Hello World" ]
}

@test "can check an unformatted file" {
  MD_FILE="$(mktemp)"
  cat <<EOC > "$MD_FILE"
Hello World
===========
EOC

  run ./entrypoint.sh true "$MD_FILE"
  [ "$status" -eq 1 ]
  [[ "$output" == *"# Hello World"* ]]
}

@test "can check a formatted file" {
  MD_FILE="$(mktemp)"
  cat <<EOC > "$MD_FILE"
# Hello World
EOC

  run ./entrypoint.sh true "$MD_FILE"
  echo "\"$output\""
  [ "$status" -eq 0 ]
  [[ "$output" == "" ]]
}
