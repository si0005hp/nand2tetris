#!/bin/bash

set -e

TEST_TARGET=${1:?'error: No test target'}

PROJECT_ROOT="$(cd $(dirname $0); pwd)/../.."
TEST_TARGET_PATH="${PROJECT_ROOT}/projects/11/${TEST_TARGET}"
TEST_OUTPUT_DIR="${PROJECT_ROOT}/projects/11/jack/test_result/${TEST_TARGET}"


rm -rf "$TEST_OUTPUT_DIR" && mkdir -p "$TEST_OUTPUT_DIR/ans" "$TEST_OUTPUT_DIR/out"
rm -f "$TEST_TARGET_PATH"/*.vm

# JackCompiler
"$PROJECT_ROOT"/tools/JackCompiler.sh "$TEST_TARGET_PATH"
cp -r "$TEST_TARGET_PATH"/*.vm "$TEST_OUTPUT_DIR/ans/"

# Our Compiler
(cd jack && mvn compile exec:java -Dexec.args="$TEST_TARGET_PATH")
cp -r "$TEST_TARGET_PATH"/*.vm "$TEST_OUTPUT_DIR/out/"


diff "$TEST_OUTPUT_DIR/ans/" "$TEST_OUTPUT_DIR/out/"

echo "[${TEST_TARGET}]: SUCCESS"
exit 0
