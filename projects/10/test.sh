#!/bin/bash

set -e

cd jack

make clean build
make test_prj10

exit 0
