

class GridSettings {
  final double? horizontalPadding;
  final double? internalPadding;
  final double? profileThumbnailBorderRadius;
  final int? rowProfileCount;
  const GridSettings({
    this.horizontalPadding,
    this.internalPadding,
    this.profileThumbnailBorderRadius,
    this.rowProfileCount,
  });

  double valueHorizontalPadding() => horizontalPadding ?? 16;
  double valueInternalPadding() => internalPadding ?? 8;
  double valueProfileThumbnailBorderRadius() => profileThumbnailBorderRadius ?? 10;
  int valueRowProfileCount() => rowProfileCount ?? 2;
}
