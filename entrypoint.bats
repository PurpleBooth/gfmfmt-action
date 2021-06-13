#!/usr/bin/env bats

@test "can use regex" {
  GITHUB_WORKSPACE="$(mktemp -d)"
  export GITHUB_WORKSPACE
  MD_DIR="$GITHUB_WORKSPACE"
  cat <<EOC > "$MD_DIR/file_one.md"
Hello World
===========
EOC
  mkdir "$MD_DIR/subdir"
  cat <<EOC > "$MD_DIR/subdir/file_two.md"
Hello World
===========
EOC

  run ./entrypoint.sh false "./(subdir|another)/file_two.md"

  cat <<EOC > "$MD_DIR/file_one_expected.md"
Hello World
===========
EOC

  [ "$status" -eq 0 ]
  [ "$(cat "$MD_DIR/file_one.md")" = "$(cat "$MD_DIR/file_one_expected.md")" ]
  [ "$(cat "$MD_DIR/subdir/file_two.md")" = "# Hello World" ]
}


@test "can format a file" {
  GITHUB_WORKSPACE="$(mktemp -d)"
  export GITHUB_WORKSPACE
  MD_FILE="$GITHUB_WORKSPACE/file.md"
  cat <<EOC > "$MD_FILE"
Hello World
===========
EOC

  run ./entrypoint.sh false ".*\.md"
  echo $output
  [ "$status" -eq 0 ]
  [ "$(cat "$MD_FILE")" = "# Hello World" ]
}

@test "can check an unformatted file" {
  GITHUB_WORKSPACE="$(mktemp -d)"
  export GITHUB_WORKSPACE
  MD_FILE="$GITHUB_WORKSPACE/file.md"
  cat <<EOC > "$MD_FILE"
Hello World
===========
EOC

  run ./entrypoint.sh true ".*\.md"
  [[ "$output" == *"# Hello World"* ]]
  [ "$status" -eq 1 ]
}

@test "can check a formatted file" {
  GITHUB_WORKSPACE="$(mktemp -d)"
  export GITHUB_WORKSPACE
  MD_FILE="$GITHUB_WORKSPACE/file.md"
  cat <<EOC > "$MD_FILE"
# Hello World
EOC

  run ./entrypoint.sh true ".*\.md"
  [ "$status" -eq 0 ]
  [[ "$output" == *"looks good"* ]]
}

@test "root is relative" {
  GITHUB_WORKSPACE="$(mktemp -d)"
  export GITHUB_WORKSPACE
  MD_FILE="$GITHUB_WORKSPACE/file.md"
  cat <<EOC > "$MD_FILE"
# Hello World
EOC

  run ./entrypoint.sh true "./file.md$"
  [ "$status" -eq 0 ]
  [[ "$output" == *"./file.md looks good"* ]]
}
