#!/bin/sh

# Xcode Cloud custom build script.
# Runs before Xcode Cloud runs xcodebuild.

# Fail this script if any subcommand fails.
set -e

# The default execution directory of this script is the ci_scripts directory.
# Change working directory to the root of the cloned repo.
cd "$CI_PRIMARY_REPOSITORY_PATH"

# Ensure Flutter and Rust/cargo are on PATH (installed in ci_post_clone.sh).
export PATH="$PATH:$HOME/flutter/bin:$HOME/.cargo/bin"

# Xcode Cloud runs xcodebuild directly, so the Flutter build settings must be
# generated before the build. The flutter build ios command normally does this,
# but here we only need the configuration step (no compilation, no codesign).
echo "==> Generating Flutter build settings (config-only)"
flutter build ios --release --config-only \
  --dart-define=GIT_COMMIT_ID="$(git rev-parse --short HEAD)"

exit 0
