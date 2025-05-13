#!/bin/bash

OUTPUT_DIR=".outputs"

# Clean
if [[ -d "$OUTPUT_DIR" ]]; then
    find "$OUTPUT_DIR" -mindepth 1 -maxdepth 1 ! -name 'Makefile' ! -name '.stowrc' -exec rm -rf {} +
fi