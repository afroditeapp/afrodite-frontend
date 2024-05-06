#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint native_utils.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'native_utils'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  s.script_phase = {
    :name => 'Build rust_utils library',
    :script => 'sh "$PODS_TARGET_SRCROOT/build_rust_utils.sh"',
    :execution_position => :before_compile,
  }

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    # Flutter.framework does not contain a i386 slice.
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'LIBRARY_SEARCH_PATHS[sdk=iphoneos*]' => '"$PODS_TARGET_SRCROOT/../rust_utils/target/aarch64-apple-ios/release"',
    'LIBRARY_SEARCH_PATHS[sdk=iphonesimulator*][arch=arm64]' => '"$PODS_TARGET_SRCROOT/../rust_utils/target/aarch64-apple-ios-sim/release"',
    'LIBRARY_SEARCH_PATHS[sdk=iphonesimulator*][arch=x86_64]' => '"$PODS_TARGET_SRCROOT/../rust_utils/target/x86_64-apple-ios/release"',
    'OTHER_LDFLAGS' => '-lrust_utils',
  }
  s.swift_version = '5.0'
end
