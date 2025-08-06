// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_profile_search_badge.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorAutomaticProfileSearchBadgeData = UnsupportedError(
    'Private constructor AutomaticProfileSearchBadgeData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$AutomaticProfileSearchBadgeData {
  bool get dataLoaded => throw _privateConstructorErrorAutomaticProfileSearchBadgeData;
  AutomaticProfileSearchBadgeState get badgeState => throw _privateConstructorErrorAutomaticProfileSearchBadgeData;

  AutomaticProfileSearchBadgeData copyWith({
    bool? dataLoaded,
    AutomaticProfileSearchBadgeState? badgeState,
  }) => throw _privateConstructorErrorAutomaticProfileSearchBadgeData;
}

/// @nodoc
abstract class _AutomaticProfileSearchBadgeData extends AutomaticProfileSearchBadgeData {
  factory _AutomaticProfileSearchBadgeData({
    bool dataLoaded,
    AutomaticProfileSearchBadgeState badgeState,
  }) = _$AutomaticProfileSearchBadgeDataImpl;
  const _AutomaticProfileSearchBadgeData._() : super._();
}

/// @nodoc
class _$AutomaticProfileSearchBadgeDataImpl extends _AutomaticProfileSearchBadgeData with DiagnosticableTreeMixin {
  static const bool _dataLoadedDefaultValue = false;
  static const AutomaticProfileSearchBadgeState _badgeStateDefaultValue = AutomaticProfileSearchBadgeState.defaultValue;
  
  _$AutomaticProfileSearchBadgeDataImpl({
    this.dataLoaded = _dataLoadedDefaultValue,
    this.badgeState = _badgeStateDefaultValue,
  }) : super._();

  @override
  final bool dataLoaded;
  @override
  final AutomaticProfileSearchBadgeState badgeState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AutomaticProfileSearchBadgeData(dataLoaded: $dataLoaded, badgeState: $badgeState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AutomaticProfileSearchBadgeData'))
      ..add(DiagnosticsProperty('dataLoaded', dataLoaded))
      ..add(DiagnosticsProperty('badgeState', badgeState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AutomaticProfileSearchBadgeDataImpl &&
        (identical(other.dataLoaded, dataLoaded) ||
          other.dataLoaded == dataLoaded) &&
        (identical(other.badgeState, badgeState) ||
          other.badgeState == badgeState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    dataLoaded,
    badgeState,
  );

  @override
  AutomaticProfileSearchBadgeData copyWith({
    Object? dataLoaded,
    Object? badgeState,
  }) => _$AutomaticProfileSearchBadgeDataImpl(
    dataLoaded: (dataLoaded ?? this.dataLoaded) as bool,
    badgeState: (badgeState ?? this.badgeState) as AutomaticProfileSearchBadgeState,
  );
}
