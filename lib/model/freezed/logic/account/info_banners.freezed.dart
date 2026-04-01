// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_banners.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorInfoBannersData = UnsupportedError(
    'Private constructor InfoBannersData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$InfoBannersData {
  Map<String, InfoBannerDismissState> get dismissStates => throw _privateConstructorErrorInfoBannersData;
  ServerMaintenanceInfo get maintenanceInfo => throw _privateConstructorErrorInfoBannersData;

  InfoBannersData copyWith({
    Map<String, InfoBannerDismissState>? dismissStates,
    ServerMaintenanceInfo? maintenanceInfo,
  }) => throw _privateConstructorErrorInfoBannersData;
}

/// @nodoc
abstract class _InfoBannersData extends InfoBannersData {
  factory _InfoBannersData({
    required Map<String, InfoBannerDismissState> dismissStates,
    required ServerMaintenanceInfo maintenanceInfo,
  }) = _$InfoBannersDataImpl;
  const _InfoBannersData._() : super._();
}

/// @nodoc
class _$InfoBannersDataImpl extends _InfoBannersData with DiagnosticableTreeMixin {
  _$InfoBannersDataImpl({
    required this.dismissStates,
    required this.maintenanceInfo,
  }) : super._();

  @override
  final Map<String, InfoBannerDismissState> dismissStates;
  @override
  final ServerMaintenanceInfo maintenanceInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InfoBannersData(dismissStates: $dismissStates, maintenanceInfo: $maintenanceInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InfoBannersData'))
      ..add(DiagnosticsProperty('dismissStates', dismissStates))
      ..add(DiagnosticsProperty('maintenanceInfo', maintenanceInfo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$InfoBannersDataImpl &&
        (identical(other.dismissStates, dismissStates) ||
          other.dismissStates == dismissStates) &&
        (identical(other.maintenanceInfo, maintenanceInfo) ||
          other.maintenanceInfo == maintenanceInfo)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    dismissStates,
    maintenanceInfo,
  );

  @override
  InfoBannersData copyWith({
    Object? dismissStates,
    Object? maintenanceInfo,
  }) => _$InfoBannersDataImpl(
    dismissStates: (dismissStates ?? this.dismissStates) as Map<String, InfoBannerDismissState>,
    maintenanceInfo: (maintenanceInfo ?? this.maintenanceInfo) as ServerMaintenanceInfo,
  );
}
