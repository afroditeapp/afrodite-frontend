import 'dart:io';

import 'package:ffigen/ffigen.dart';

Future<void> main() async {
  final packageRoot = Platform.script.resolve('../');

  final generator = FfiGenerator(
    input: Input(
      entryPoints: [packageRoot.resolve('src/native_utils_ffi.h')],
      include: (header) => header.path.endsWith('native_utils_ffi.h'),
    ),
    output: Output(
      dart: DartOutput(
        path: packageRoot.resolve('lib/src/native_utils_ffi_bindings_generated.dart'),
      ),
      style: const NativeExternalBindings(),
      commentType: const CommentType(CommentStyle.any, CommentLength.full),
      preamble: '''
// ignore_for_file: always_specify_types
// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
''',
    ),
    visitors: [
      Visitor(
        func: (node) {
          node.isIncluded = true;
          node.isLeaf = true;
        },
        struct: (node) {
          node.isIncluded = true;
        },
      ),
    ],
  );

  await generator.generate();
}
