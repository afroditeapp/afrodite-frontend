#!/bin/sh

# Xcode Cloud custom build script.
# Runs after Xcode Cloud clones the repository.

# Fail this script if any subcommand fails.
set -e

# The default execution directory of this script is the ci_scripts directory.
# Change working directory to the root of the cloned repo.
cd "$CI_PRIMARY_REPOSITORY_PATH"

FLUTTER_VERSION="3.47.4"
echo "==> Installing Flutter $FLUTTER_VERSION"
git clone https://github.com/flutter/flutter.git --depth 1 -b "$FLUTTER_VERSION" "$HOME/flutter"
export PATH="$PATH:$HOME/flutter/bin"

echo "==> Pre-caching iOS artifacts"
flutter precache --ios

echo "==> Installing Rust toolchain (pinned by rust-toolchain.toml)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
export PATH="$PATH:$HOME/.cargo/bin"

echo "==> Installing Flutter dependencies"
flutter pub get

exit 0
