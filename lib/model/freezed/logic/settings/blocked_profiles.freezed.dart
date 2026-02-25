// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_profiles.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorBlockedProfilesData = UnsupportedError(
    'Private constructor BlockedProfilesData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$BlockedProfilesData {
  bool get unblockOngoing => throw _privateConstructorErrorBlockedProfilesData;
  AccountId? get lastUnblocked => throw _privateConstructorErrorBlockedProfilesData;

  BlockedProfilesData copyWith({
    bool? unblockOngoing,
    AccountId? lastUnblocked,
  }) => throw _privateConstructorErrorBlockedProfilesData;
}

/// @nodoc
abstract class _BlockedProfilesData extends BlockedProfilesData {
  factory _BlockedProfilesData({
    bool unblockOngoing,
    AccountId? lastUnblocked,
  }) = _$BlockedProfilesDataImpl;
  _BlockedProfilesData._() : super._();
}

/// @nodoc
class _$BlockedProfilesDataImpl extends _BlockedProfilesData with DiagnosticableTreeMixin {
  static const bool _unblockOngoingDefaultValue = false;

  _$BlockedProfilesDataImpl({
    this.unblockOngoing = _unblockOngoingDefaultValue,
    this.lastUnblocked,
  }) : super._();

  @override
  final bool unblockOngoing;
  @override
  final AccountId? lastUnblocked;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BlockedProfilesData(unblockOngoing: $unblockOngoing, lastUnblocked: $lastUnblocked)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BlockedProfilesData'))
      ..add(DiagnosticsProperty('unblockOngoing', unblockOngoing))
      ..add(DiagnosticsProperty('lastUnblocked', lastUnblocked));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$BlockedProfilesDataImpl &&
        (identical(other.unblockOngoing, unblockOngoing) ||
          other.unblockOngoing == unblockOngoing) &&
        (identical(other.lastUnblocked, lastUnblocked) ||
          other.lastUnblocked == lastUnblocked)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    unblockOngoing,
    lastUnblocked,
  );

  @override
  BlockedProfilesData copyWith({
    Object? unblockOngoing,
    Object? lastUnblocked = _detectDefaultValueInCopyWith,
  }) => _$BlockedProfilesDataImpl(
    unblockOngoing: (unblockOngoing ?? this.unblockOngoing) as bool,
    lastUnblocked: (lastUnblocked == _detectDefaultValueInCopyWith ? this.lastUnblocked : lastUnblocked) as AccountId?,
  );
}
