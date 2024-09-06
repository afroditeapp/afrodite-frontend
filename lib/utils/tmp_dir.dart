


import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class TmpDirUtils {
  static Future<String> initialSetupSecuritySelfieFilePath() async {
    return await initialSetupFilePath("security_selfie.jpg");
  }

  static Future<String> initialSetupFilePath(String fileName) async {
    final tmpDir = await getTemporaryDirectory();
    final tmpDirPath = p.join(tmpDir.path, "initial_setup");
    final dir = Directory(tmpDirPath);
    if (!await dir.exists()) {
      await dir.create(); // TODO: Error handling
    }
    final filePath = p.join(tmpDirPath, fileName);
    return filePath;
  }

  static Future<File> emptyMapTileFilePath() async {
    final tmpDir = await getTemporaryDirectory();
    final imgPath = p.join(tmpDir.path, "empty_map_tile.png");
    final imgFile = File(imgPath);
    return imgFile;
  }
}
