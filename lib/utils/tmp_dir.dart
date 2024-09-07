


import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class TmpDirUtils {
  static Future<File> emptyMapTileFilePath() async {
    final tmpDir = await getTemporaryDirectory();
    final imgPath = p.join(tmpDir.path, "empty_map_tile.png");
    final imgFile = File(imgPath);
    return imgFile;
  }
}
