


import 'dart:io';

import 'package:path_provider/path_provider.dart';

class TmpDirUtils {
  static Future<String> initialSetupFilePath(String fileName) async {
    final tmpDir = await getTemporaryDirectory();
    return "${tmpDir.path}/initial_setup/$fileName";
  }

  static Future<File> emptyMapTileFilePath() async {
    final tmpDir = await getTemporaryDirectory();
    final imgPath = "${tmpDir.path}/empty_map_tile.png";
    final imgFile = File(imgPath);
    return imgFile;
  }
}
