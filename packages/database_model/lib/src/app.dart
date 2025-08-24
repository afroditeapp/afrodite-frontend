class GridSettings {
  final int? itemSizeMode;
  final int? paddingMode;
  const GridSettings({this.itemSizeMode, this.paddingMode});

  GridSettingMode _intToGridSettingMode(int? value, GridSettingMode defaultValue) {
    return switch (value) {
      0 => GridSettingMode.small,
      1 => GridSettingMode.medium,
      2 => GridSettingMode.large,
      3 => GridSettingMode.disabled,
      _ => defaultValue,
    };
  }

  GridSettingMode valueItemSizeMode() => _intToGridSettingMode(itemSizeMode, GridSettingMode.large);
  GridSettingMode valuePaddingMode() => _intToGridSettingMode(paddingMode, GridSettingMode.large);

  double valueHorizontalPadding() => switch (valuePaddingMode()) {
    GridSettingMode.small => 4,
    GridSettingMode.medium => 8,
    GridSettingMode.large => 16,
    GridSettingMode.disabled => 0,
  };

  double valueInternalPadding() => switch (valuePaddingMode()) {
    GridSettingMode.small => 2,
    GridSettingMode.medium => 4,
    GridSettingMode.large => 8,
    GridSettingMode.disabled => 0,
  };

  double valueProfileThumbnailBorderRadius() => switch (valuePaddingMode()) {
    GridSettingMode.disabled => 0,
    _ => 10,
  };

  int valueRowProfileCount() {
    const int DEFAULT = 2;
    return switch (valueItemSizeMode()) {
      GridSettingMode.small => 4,
      GridSettingMode.medium => 3,
      GridSettingMode.large => DEFAULT,
      _ => DEFAULT,
    };
  }
}

enum GridSettingMode {
  small,
  medium,
  large,
  disabled;

  int toInt() => switch (this) {
    small => 0,
    medium => 1,
    large => 2,
    disabled => 3,
  };
}
