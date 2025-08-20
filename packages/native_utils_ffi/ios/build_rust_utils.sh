# Make Cargo available
export PATH="$HOME/.cargo/bin:$PATH"

# Fix for "ld: library 'System' not found" occuring when Xcode runs
# this script. The fix is from here:
# https://github.com/corrosion-rs/corrosion/pull/167/files
# https://github.com/corrosion-rs/corrosion/issues/104
export LIBRARY_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

cd $PODS_TARGET_SRCROOT
cd ..
cd rust_utils

rustup target add aarch64-apple-ios
rustup target add aarch64-apple-ios-sim
rustup target add x86_64-apple-ios

# Build target/aarch64-apple-ios/release/librust_utils.a
cargo build --release --target aarch64-apple-ios

# Build target/aarch64-apple-ios-sim/release/librust_utils.a
cargo build --release --target aarch64-apple-ios-sim

# Build target/x86_64-apple-ios/release/librust_utils.a
cargo build --release --target x86_64-apple-ios
