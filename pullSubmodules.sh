#!/bin/bash

set -e

if [ ! -f ".gitmodules" ]; then
    echo "No .gitmodules file found. Are you in the root of a git repo?"
    exit 1
fi

git submodule init

git submodule status | while read -r sha path extras; do
    # Lines starting with '-' mean the submodule hasn't been cloned yet
    if [[ "$sha" == -* ]]; then
        echo "Cloning missing submodule: $path"
        git submodule update --init "$path"
    else
        echo "Skipping (already exists): $path"
    fi
done