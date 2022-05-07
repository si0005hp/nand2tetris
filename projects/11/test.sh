#!/bin/bash

set -e

PROJECT_ROOT="$(cd $(dirname $0); pwd)/../.."

run_test() {
  local test_target=${1:?'error: No test target'}
  local test_target_path="${PROJECT_ROOT}/projects/11/${test_target}"
  local test_output_dir="${PROJECT_ROOT}/projects/11/jack/test_result/${test_target}"

  rm -rf "$test_output_dir" && mkdir -p "$test_output_dir/ans" "$test_output_dir/out"
  rm -f "$test_target_path"/*.vm

  # Run JackCompiler
  "$PROJECT_ROOT"/tools/JackCompiler.sh "$test_target_path"
  cp -r "$test_target_path"/*.vm "$test_output_dir/ans/"

  # Run our Compiler
  (cd jack && mvn exec:java -Dexec.args="$test_target_path")
  cp -r "$test_target_path"/*.vm "$test_output_dir/out/"

  # Compare results
  diff "$test_output_dir/ans/" "$test_output_dir/out/"
  echo "[${test_target}]: SUCCESS"
}

# build
(cd jack && mvn clean compile)

for target in "${@}"; do
  run_test "$target"
done

echo "All tests passed"

exit 0
