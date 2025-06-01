
import 'package:database/database.dart';
import 'package:flutter/material.dart';

extension GridSettingsExtensions on GridSettings {
  SliverGridDelegateWithFixedCrossAxisCount toSliverGridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: valueRowProfileCount(),
      crossAxisSpacing: valueInternalPadding(),
      mainAxisSpacing: valueInternalPadding(),
    );
  }

  GridSettings copyWith(
    {
      double? horizontalPadding,
      double? internalPadding,
      double? profileThumbnailBorderRadius,
      int? rowProfileCount,
    }
  ) {
    return GridSettings(
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      internalPadding: internalPadding ?? this.internalPadding,
      profileThumbnailBorderRadius: profileThumbnailBorderRadius ?? this.profileThumbnailBorderRadius,
      rowProfileCount: rowProfileCount ?? this.rowProfileCount,
    );
  }
}
