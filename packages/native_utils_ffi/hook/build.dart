import 'package:hooks/hooks.dart';
import 'package:native_toolchain_rust/native_toolchain_rust.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    await const RustBuilder(
      assetName: 'src/native_utils_ffi_bindings_generated.dart',
      cratePath: 'rust_utils',
    ).run(input: input, output: output);
  });
}
