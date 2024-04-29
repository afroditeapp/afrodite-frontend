# Flutter tooling requires at least CMake 3.10 and Corrosion
# requires at least CMake 3.14.
cmake_minimum_required(VERSION 3.14)

project(native_utils_library VERSION 0.0.1 LANGUAGES C)

# Download Corrosion
include(FetchContent)
FetchContent_Declare(
    Corrosion
    GIT_REPOSITORY https://github.com/corrosion-rs/corrosion.git
    GIT_TAG v0.4
)
FetchContent_MakeAvailable(Corrosion)

corrosion_import_crate(MANIFEST_PATH ../rust_utils/Cargo.toml)

add_library(native_utils SHARED
  "native_utils.c"
)

set_target_properties(native_utils PROPERTIES
  PUBLIC_HEADER native_utils.h
  OUTPUT_NAME "native_utils"
)

target_link_libraries(native_utils PRIVATE rust_utils)

# Current code does not use Dart API
# target_compile_definitions(native_utils PUBLIC DART_SHARED_LIB)
