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
  AutomaticProfileSearchBadgeState get badgeState => throw _privateConstructorErrorAutomaticProfileSearchBadgeData;

  AutomaticProfileSearchBadgeData copyWith({
    AutomaticProfileSearchBadgeState? badgeState,
  }) => throw _privateConstructorErrorAutomaticProfileSearchBadgeData;
}

/// @nodoc
abstract class _AutomaticProfileSearchBadgeData extends AutomaticProfileSearchBadgeData {
  factory _AutomaticProfileSearchBadgeData({
    AutomaticProfileSearchBadgeState badgeState,
  }) = _$AutomaticProfileSearchBadgeDataImpl;
  const _AutomaticProfileSearchBadgeData._() : super._();
}

/// @nodoc
class _$AutomaticProfileSearchBadgeDataImpl extends _AutomaticProfileSearchBadgeData with DiagnosticableTreeMixin {
  static const AutomaticProfileSearchBadgeState _badgeStateDefaultValue = AutomaticProfileSearchBadgeState.defaultValue;

  _$AutomaticProfileSearchBadgeDataImpl({
    this.badgeState = _badgeStateDefaultValue,
  }) : super._();

  @override
  final AutomaticProfileSearchBadgeState badgeState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AutomaticProfileSearchBadgeData(badgeState: $badgeState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AutomaticProfileSearchBadgeData'))
      ..add(DiagnosticsProperty('badgeState', badgeState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AutomaticProfileSearchBadgeDataImpl &&
        (identical(other.badgeState, badgeState) ||
          other.badgeState == badgeState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    badgeState,
  );

  @override
  AutomaticProfileSearchBadgeData copyWith({
    Object? badgeState,
  }) => _$AutomaticProfileSearchBadgeDataImpl(
    badgeState: (badgeState ?? this.badgeState) as AutomaticProfileSearchBadgeState,
  );
}
