#!/usr/bin/env bash

# Automatically installs swiftenv and run's swiftenv install.
# This script was designed for usage in CI systems.

export SWIFTENV_ROOT="${SWIFTENV_ROOT:-${HOME}/.swiftenv}"

if [ -d "$SWIFTENV_ROOT/versions" ]; then
  mv "$SWIFTENV_ROOT/versions" swiftenv_versions
fi

if [ -d "$SWIFTENV_ROOT" ]; then
  rm -rf "$SWIFTENV_ROOT"
fi

git clone --depth 1 https://github.com/kylef/swiftenv.git "$SWIFTENV_ROOT"

if [ -d swiftenv_versions ]; then 
  mv swiftenv_versions "$SWIFTENV_ROOT/versions"
fi

export PATH="$SWIFTENV_ROOT/bin:$SWIFTENV_ROOT/shims:$PATH"

if [ -f ".swift-version" ] || [ -n "$SWIFT_VERSION" ]; then
  swiftenv install -s
else
  swiftenv rehash
fi

eval "$(swiftenv init -)"