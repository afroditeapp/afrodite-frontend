import 'package:flutter/widgets.dart';

int calculateCachedImageSize(BuildContext context, double size) {
  return (size * MediaQuery.devicePixelRatioOf(context)).round();
}
