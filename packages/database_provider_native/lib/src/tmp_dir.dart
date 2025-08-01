import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// TODO(quality): Error handling
class TmpDirUtils {
  static Future<String> sqliteTmpDir() async {
    final tmpDir = await getTemporaryDirectory();
    final sqliteTmpPath = p.join(tmpDir.path, "sqlite");
    final dir = Directory(sqliteTmpPath);
    if (!await dir.exists()) {
      await dir.create();
    }
    return sqliteTmpPath;
  }
}
