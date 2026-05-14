#!/bin/bash

set -e

if [ ! -f ".gitmodules" ]; then
    echo "No .gitmodules file found. Are you in the root of a git repo?"
    exit 1
fi

git submodule init

git submodule status | while read -r sha path extras; do
    echo "Updating submodule: $path"
    git submodule update --init --remote "$path"
done