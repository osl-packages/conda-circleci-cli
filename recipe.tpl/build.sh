#!/usr/bin/env bash
export VERSION=$PKG_VERSION
export DESTDIR=${PREFIX}/bin
./install.sh
chmod +x ${PREFIX}/bin/circleci
