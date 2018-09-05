#!/bin/sh
#  This file should include all tests run on our assembly emulator.

# exit on any error with that error status:
set -e

export TEST_DIR="devops/templates"
export CODE_DIR="utils"

for test_file in $TEST_DIR/*.html; 
do
    echo 'Checking file:' $test_file 
    python3 $CODE_DIR/html_checker.py "$test_file"; 
done
