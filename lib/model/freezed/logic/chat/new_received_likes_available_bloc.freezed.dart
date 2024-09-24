// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_received_likes_available_bloc.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorNewReceivedLikesAvailableData = UnsupportedError(
    'Private constructor NewReceivedLikesAvailableData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NewReceivedLikesAvailableData {
  int get newReceivedLikesCount => throw _privateConstructorErrorNewReceivedLikesAvailableData;

  NewReceivedLikesAvailableData copyWith({
    int? newReceivedLikesCount,
  }) => throw _privateConstructorErrorNewReceivedLikesAvailableData;
}

/// @nodoc
abstract class _NewReceivedLikesAvailableData extends NewReceivedLikesAvailableData {
  factory _NewReceivedLikesAvailableData({
    int newReceivedLikesCount,
  }) = _$NewReceivedLikesAvailableDataImpl;
  const _NewReceivedLikesAvailableData._() : super._();
}

/// @nodoc
class _$NewReceivedLikesAvailableDataImpl extends _NewReceivedLikesAvailableData with DiagnosticableTreeMixin {
  static const int _newReceivedLikesCountDefaultValue = 0;
  
  _$NewReceivedLikesAvailableDataImpl({
    this.newReceivedLikesCount = _newReceivedLikesCountDefaultValue,
  }) : super._();

  @override
  final int newReceivedLikesCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewReceivedLikesAvailableData(newReceivedLikesCount: $newReceivedLikesCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewReceivedLikesAvailableData'))
      ..add(DiagnosticsProperty('newReceivedLikesCount', newReceivedLikesCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NewReceivedLikesAvailableDataImpl &&
        (identical(other.newReceivedLikesCount, newReceivedLikesCount) ||
          other.newReceivedLikesCount == newReceivedLikesCount)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    newReceivedLikesCount,
  );

  @override
  NewReceivedLikesAvailableData copyWith({
    Object? newReceivedLikesCount,
  }) => _$NewReceivedLikesAvailableDataImpl(
    newReceivedLikesCount: (newReceivedLikesCount ?? this.newReceivedLikesCount) as int,
  );
}
