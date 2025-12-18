import "dart:io";
import "dart:typed_data";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as path;
import "package:share_plus/share_plus.dart";

Future<void> shareBackupFile(String fileName, Uint8List bytes) async {
  File? tempFile;
  try {
    final cacheDir = await getTemporaryDirectory();
    final filePath = path.join(cacheDir.path, fileName);
    tempFile = File(filePath);
    await tempFile.writeAsBytes(bytes);

    final xFile = XFile(filePath, mimeType: 'application/octet-stream');
    final params = ShareParams(files: [xFile]);
    await SharePlus.instance.share(params);
  } finally {
    // Clean up temp file
    if (tempFile != null && await tempFile.exists()) {
      await tempFile.delete();
    }
  }
}
