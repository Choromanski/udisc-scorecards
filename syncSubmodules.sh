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

    branch=$(git config -f .gitmodules "submodule.$path.branch")
    branch=${branch:-master}

    echo "Checking out $branch in $path"
    git -C "$path" checkout "$branch"
    git -C "$path" pull origin "$branch"
done