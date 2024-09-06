# Flutter tooling requires at least CMake 3.10 and Corrosion
# requires at least CMake 3.15.
cmake_minimum_required(VERSION 3.15)

project(native_utils_ffi_library VERSION 0.0.1 LANGUAGES C)

# Download Corrosion
include(FetchContent)
FetchContent_Declare(
    Corrosion
    GIT_REPOSITORY https://github.com/corrosion-rs/corrosion.git
    GIT_TAG v0.5
)
FetchContent_MakeAvailable(Corrosion)

corrosion_import_crate(MANIFEST_PATH ../rust_utils/Cargo.toml)

add_library(native_utils_ffi SHARED
  "native_utils_ffi.c"
)

set_target_properties(native_utils_ffi PROPERTIES
  PUBLIC_HEADER native_utils_ffi.h
  OUTPUT_NAME "native_utils_ffi"
)

target_link_libraries(native_utils_ffi PRIVATE rust_utils)

# Current code does not use Dart API
# target_compile_definitions(native_utils_ffi PUBLIC DART_SHARED_LIB)
