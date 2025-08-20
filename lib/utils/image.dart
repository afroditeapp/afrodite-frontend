import 'package:flutter/material.dart';

/// Crop factor which is used to make longer size less long
/// so that the aspect ratio is at least 4:3.
double cropFactorToAspectRatioAtLeast43(Size size) {
  final width = size.longestSide;
  final height = size.shortestSide;

  // Stop cropping to 4:3 aspect ratio
  if (width / height < 4 / 3) {
    return 1;
  }

  const invertedWantedAspectRatio = 3 / 4;
  final wantedHeight = invertedWantedAspectRatio * width;
  final cropFactor = height / wantedHeight;
  return cropFactor;
}
