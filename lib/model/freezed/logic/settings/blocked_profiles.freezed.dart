// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_profiles.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorBlockedProfilesData = UnsupportedError(
    'Private constructor BlockedProfilesData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$BlockedProfilesData {
  bool get unblockOngoing => throw _privateConstructorErrorBlockedProfilesData;

  BlockedProfilesData copyWith({
    bool? unblockOngoing,
  }) => throw _privateConstructorErrorBlockedProfilesData;
}

/// @nodoc
abstract class _BlockedProfilesData extends BlockedProfilesData {
  factory _BlockedProfilesData({
    bool unblockOngoing,
  }) = _$BlockedProfilesDataImpl;
  _BlockedProfilesData._() : super._();
}

/// @nodoc
class _$BlockedProfilesDataImpl extends _BlockedProfilesData with DiagnosticableTreeMixin {
  static const bool _unblockOngoingDefaultValue = false;

  _$BlockedProfilesDataImpl({
    this.unblockOngoing = _unblockOngoingDefaultValue,
  }) : super._();

  @override
  final bool unblockOngoing;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BlockedProfilesData(unblockOngoing: $unblockOngoing)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BlockedProfilesData'))
      ..add(DiagnosticsProperty('unblockOngoing', unblockOngoing));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$BlockedProfilesDataImpl &&
        (identical(other.unblockOngoing, unblockOngoing) ||
          other.unblockOngoing == unblockOngoing)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    unblockOngoing,
  );

  @override
  BlockedProfilesData copyWith({
    Object? unblockOngoing,
  }) => _$BlockedProfilesDataImpl(
    unblockOngoing: (unblockOngoing ?? this.unblockOngoing) as bool,
  );
}
