import "dart:typed_data";
import "package:share_plus/share_plus.dart";

Future<void> shareBackupFile(String fileName, Uint8List bytes) async {
  final xFile = XFile.fromData(bytes, mimeType: 'application/octet-stream');
  final params = ShareParams(files: [xFile], fileNameOverrides: [fileName]);
  await SharePlus.instance.share(params);
}
