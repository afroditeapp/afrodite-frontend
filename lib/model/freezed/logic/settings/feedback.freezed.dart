// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

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
final _privateConstructorErrorFeedbackData = UnsupportedError(
    'Private constructor FeedbackData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$FeedbackData {
  UpdateState get updateState => throw _privateConstructorErrorFeedbackData;
  FeedbackConfigData get config => throw _privateConstructorErrorFeedbackData;
  String? get categoryKey => throw _privateConstructorErrorFeedbackData;
  String get body => throw _privateConstructorErrorFeedbackData;

  FeedbackData copyWith({
    UpdateState? updateState,
    FeedbackConfigData? config,
    String? categoryKey,
    String? body,
  }) => throw _privateConstructorErrorFeedbackData;
}

/// @nodoc
abstract class _FeedbackData extends FeedbackData {
  factory _FeedbackData({
    UpdateState updateState,
    FeedbackConfigData config,
    String? categoryKey,
    String body,
  }) = _$FeedbackDataImpl;
  _FeedbackData._() : super._();
}

/// @nodoc
class _$FeedbackDataImpl extends _FeedbackData {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const FeedbackConfigData _configDefaultValue = FeedbackConfigData();
  static const String _bodyDefaultValue = "";

  _$FeedbackDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.config = _configDefaultValue,
    this.categoryKey,
    this.body = _bodyDefaultValue,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final FeedbackConfigData config;
  @override
  final String? categoryKey;
  @override
  final String body;

  @override
  String toString() {
    return 'FeedbackData(updateState: $updateState, config: $config, categoryKey: $categoryKey, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$FeedbackDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.config, config) ||
          other.config == config) &&
        (identical(other.categoryKey, categoryKey) ||
          other.categoryKey == categoryKey) &&
        (identical(other.body, body) ||
          other.body == body)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    config,
    categoryKey,
    body,
  );

  @override
  FeedbackData copyWith({
    Object? updateState,
    Object? config,
    Object? categoryKey = _detectDefaultValueInCopyWith,
    Object? body,
  }) => _$FeedbackDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    config: (config ?? this.config) as FeedbackConfigData,
    categoryKey: (categoryKey == _detectDefaultValueInCopyWith ? this.categoryKey : categoryKey) as String?,
    body: (body ?? this.body) as String,
  );
}
