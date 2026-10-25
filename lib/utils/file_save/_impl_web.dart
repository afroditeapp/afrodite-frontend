import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:web/web.dart';

/// File System Access API is available only on modern Chromium based
/// browsers.
bool _isFileSystemAccessApiAvailable() {
  return window.hasProperty('showSaveFilePicker'.toJS).toDart;
}

/// Saves [bytes] to a file named [fileName] like
/// `FlutterFileSaver().writeFileAsBytes` does.
///
/// Exceptions are thrown normally, except when the browser doesn't
/// support the File System Access API (e.g. Firefox, Safari). In
/// those browsers the file is downloaded automatically and the
/// result can't be observed, so errors are ignored.
Future<void> saveFileAsBytes({required String fileName, required Uint8List bytes}) async {
  if (!_isFileSystemAccessApiAvailable()) {
    try {
      await FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: bytes);
    } catch (_) {
      // The result of the download can't be observed.
    }
    return;
  }

  await FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: bytes);
}
