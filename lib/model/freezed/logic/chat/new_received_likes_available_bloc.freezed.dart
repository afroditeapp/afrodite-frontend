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
  bool get triggerReceivedLikesRefresh => throw _privateConstructorErrorNewReceivedLikesAvailableData;
  bool get showRefreshButton => throw _privateConstructorErrorNewReceivedLikesAvailableData;

  NewReceivedLikesAvailableData copyWith({
    int? newReceivedLikesCount,
    bool? triggerReceivedLikesRefresh,
    bool? showRefreshButton,
  }) => throw _privateConstructorErrorNewReceivedLikesAvailableData;
}

/// @nodoc
abstract class _NewReceivedLikesAvailableData extends NewReceivedLikesAvailableData {
  factory _NewReceivedLikesAvailableData({
    int newReceivedLikesCount,
    bool triggerReceivedLikesRefresh,
    bool showRefreshButton,
  }) = _$NewReceivedLikesAvailableDataImpl;
  const _NewReceivedLikesAvailableData._() : super._();
}

/// @nodoc
class _$NewReceivedLikesAvailableDataImpl extends _NewReceivedLikesAvailableData with DiagnosticableTreeMixin {
  static const int _newReceivedLikesCountDefaultValue = 0;
  static const bool _triggerReceivedLikesRefreshDefaultValue = false;
  static const bool _showRefreshButtonDefaultValue = false;

  _$NewReceivedLikesAvailableDataImpl({
    this.newReceivedLikesCount = _newReceivedLikesCountDefaultValue,
    this.triggerReceivedLikesRefresh = _triggerReceivedLikesRefreshDefaultValue,
    this.showRefreshButton = _showRefreshButtonDefaultValue,
  }) : super._();

  @override
  final int newReceivedLikesCount;
  @override
  final bool triggerReceivedLikesRefresh;
  @override
  final bool showRefreshButton;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewReceivedLikesAvailableData(newReceivedLikesCount: $newReceivedLikesCount, triggerReceivedLikesRefresh: $triggerReceivedLikesRefresh, showRefreshButton: $showRefreshButton)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewReceivedLikesAvailableData'))
      ..add(DiagnosticsProperty('newReceivedLikesCount', newReceivedLikesCount))
      ..add(DiagnosticsProperty('triggerReceivedLikesRefresh', triggerReceivedLikesRefresh))
      ..add(DiagnosticsProperty('showRefreshButton', showRefreshButton));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NewReceivedLikesAvailableDataImpl &&
        (identical(other.newReceivedLikesCount, newReceivedLikesCount) ||
          other.newReceivedLikesCount == newReceivedLikesCount) &&
        (identical(other.triggerReceivedLikesRefresh, triggerReceivedLikesRefresh) ||
          other.triggerReceivedLikesRefresh == triggerReceivedLikesRefresh) &&
        (identical(other.showRefreshButton, showRefreshButton) ||
          other.showRefreshButton == showRefreshButton)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    newReceivedLikesCount,
    triggerReceivedLikesRefresh,
    showRefreshButton,
  );

  @override
  NewReceivedLikesAvailableData copyWith({
    Object? newReceivedLikesCount,
    Object? triggerReceivedLikesRefresh,
    Object? showRefreshButton,
  }) => _$NewReceivedLikesAvailableDataImpl(
    newReceivedLikesCount: (newReceivedLikesCount ?? this.newReceivedLikesCount) as int,
    triggerReceivedLikesRefresh: (triggerReceivedLikesRefresh ?? this.triggerReceivedLikesRefresh) as bool,
    showRefreshButton: (showRefreshButton ?? this.showRefreshButton) as bool,
  );
}
