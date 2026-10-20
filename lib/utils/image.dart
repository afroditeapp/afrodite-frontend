import "dart:typed_data";
import "dart:ui" show Canvas, Color, ImageByteFormat, Paint, PictureRecorder, Rect;

/// Create a PNG image filled with a single color.
Future<Uint8List> createSolidColorPng(Color color, {int width = 1, int height = 1}) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()), Paint()..color = color);
  final image = await recorder.endRecording().toImage(width, height);
  final bytes = await image.toByteData(format: ImageByteFormat.png);
  image.dispose();
  return bytes!.buffer.asUint8List();
}
