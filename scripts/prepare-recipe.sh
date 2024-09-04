#!/usr/bin/env bash

set -ex

export VERSION_PATTERN="__VERSION__"
export GIT_FOLDER_NAME="circleci-cli"
export GIT_URL="https://github.com/CircleCI-Public/${GIT_FOLDER_NAME}.git"
export BUILD_NUMBER=1

rm -rf recipe
cp -R recipe.tpl recipe

mkdir -p src
pushd src
  if [ ! -d "$GIT_FOLDER_NAME" ]; then
    git clone $GIT_URL
  fi
  cd circleci-cli
  git fetch --all
  git fetch --tags
  VERSION_RAW=$(git describe --tags `git rev-list --tags --max-count=1`)
  VERSION="${VERSION_RAW#v}"
  git checkout "$VERSION_RAW"
popd

echo ${VERSION}

sed -i "s|__VERSION__|${VERSION}|" ./recipe/meta.yaml
