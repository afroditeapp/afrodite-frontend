import 'dart:typed_data';

import 'package:flutter_file_saver/flutter_file_saver.dart';

/// Saves [bytes] to a file named [fileName] like
/// `FlutterFileSaver().writeFileAsBytes` does.
///
/// Throws exceptions normally.
Future<void> saveFileAsBytes({required String fileName, required Uint8List bytes}) async {
  await FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: bytes);
}
