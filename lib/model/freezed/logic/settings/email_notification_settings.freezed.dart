// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_notification_settings.dart';

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
final _privateConstructorErrorEmailNotificationSettingsData = UnsupportedError(
    'Private constructor EmailNotificationSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EmailNotificationSettingsData {
  UpdateState get updateState => throw _privateConstructorErrorEmailNotificationSettingsData;
  EmailNotificationCategoryData get categories => throw _privateConstructorErrorEmailNotificationSettingsData;
  EditedEmailNotificationSettingsData get edited => throw _privateConstructorErrorEmailNotificationSettingsData;

  EmailNotificationSettingsData copyWith({
    UpdateState? updateState,
    EmailNotificationCategoryData? categories,
    EditedEmailNotificationSettingsData? edited,
  }) => throw _privateConstructorErrorEmailNotificationSettingsData;
}

/// @nodoc
abstract class _EmailNotificationSettingsData extends EmailNotificationSettingsData {
  factory _EmailNotificationSettingsData({
    UpdateState updateState,
    required EmailNotificationCategoryData categories,
    required EditedEmailNotificationSettingsData edited,
  }) = _$EmailNotificationSettingsDataImpl;
  _EmailNotificationSettingsData._() : super._();
}

/// @nodoc
class _$EmailNotificationSettingsDataImpl extends _EmailNotificationSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();

  _$EmailNotificationSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    required this.categories,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final EmailNotificationCategoryData categories;
  @override
  final EditedEmailNotificationSettingsData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EmailNotificationSettingsData(updateState: $updateState, categories: $categories, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EmailNotificationSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('edited', edited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EmailNotificationSettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.categories, categories) ||
          other.categories == categories) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    categories,
    edited,
  );

  @override
  EmailNotificationSettingsData copyWith({
    Object? updateState,
    Object? categories,
    Object? edited,
  }) => _$EmailNotificationSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    categories: (categories ?? this.categories) as EmailNotificationCategoryData,
    edited: (edited ?? this.edited) as EditedEmailNotificationSettingsData,
  );
}

/// @nodoc
final _privateConstructorErrorEmailNotificationCategoryData = UnsupportedError(
    'Private constructor EmailNotificationCategoryData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EmailNotificationCategoryData {
  bool get messages => throw _privateConstructorErrorEmailNotificationCategoryData;
  bool get likes => throw _privateConstructorErrorEmailNotificationCategoryData;

  EmailNotificationCategoryData copyWith({
    bool? messages,
    bool? likes,
  }) => throw _privateConstructorErrorEmailNotificationCategoryData;
}

/// @nodoc
abstract class _EmailNotificationCategoryData extends EmailNotificationCategoryData {
  factory _EmailNotificationCategoryData({
    bool messages,
    bool likes,
  }) = _$EmailNotificationCategoryDataImpl;
  _EmailNotificationCategoryData._() : super._();
}

/// @nodoc
class _$EmailNotificationCategoryDataImpl extends _EmailNotificationCategoryData with DiagnosticableTreeMixin {
  static const bool _messagesDefaultValue = true;
  static const bool _likesDefaultValue = true;

  _$EmailNotificationCategoryDataImpl({
    this.messages = _messagesDefaultValue,
    this.likes = _likesDefaultValue,
  }) : super._();

  @override
  final bool messages;
  @override
  final bool likes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EmailNotificationCategoryData(messages: $messages, likes: $likes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EmailNotificationCategoryData'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('likes', likes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EmailNotificationCategoryDataImpl &&
        (identical(other.messages, messages) ||
          other.messages == messages) &&
        (identical(other.likes, likes) ||
          other.likes == likes)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messages,
    likes,
  );

  @override
  EmailNotificationCategoryData copyWith({
    Object? messages,
    Object? likes,
  }) => _$EmailNotificationCategoryDataImpl(
    messages: (messages ?? this.messages) as bool,
    likes: (likes ?? this.likes) as bool,
  );
}

/// @nodoc
final _privateConstructorErrorEditedEmailNotificationSettingsData = UnsupportedError(
    'Private constructor EditedEmailNotificationSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedEmailNotificationSettingsData {
  bool? get messages => throw _privateConstructorErrorEditedEmailNotificationSettingsData;
  bool? get likes => throw _privateConstructorErrorEditedEmailNotificationSettingsData;

  EditedEmailNotificationSettingsData copyWith({
    bool? messages,
    bool? likes,
  }) => throw _privateConstructorErrorEditedEmailNotificationSettingsData;
}

/// @nodoc
abstract class _EditedEmailNotificationSettingsData extends EditedEmailNotificationSettingsData {
  factory _EditedEmailNotificationSettingsData({
    bool? messages,
    bool? likes,
  }) = _$EditedEmailNotificationSettingsDataImpl;
  _EditedEmailNotificationSettingsData._() : super._();
}

/// @nodoc
class _$EditedEmailNotificationSettingsDataImpl extends _EditedEmailNotificationSettingsData with DiagnosticableTreeMixin {
  _$EditedEmailNotificationSettingsDataImpl({
    this.messages,
    this.likes,
  }) : super._();

  @override
  final bool? messages;
  @override
  final bool? likes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedEmailNotificationSettingsData(messages: $messages, likes: $likes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedEmailNotificationSettingsData'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('likes', likes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedEmailNotificationSettingsDataImpl &&
        (identical(other.messages, messages) ||
          other.messages == messages) &&
        (identical(other.likes, likes) ||
          other.likes == likes)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messages,
    likes,
  );

  @override
  EditedEmailNotificationSettingsData copyWith({
    Object? messages = _detectDefaultValueInCopyWith,
    Object? likes = _detectDefaultValueInCopyWith,
  }) => _$EditedEmailNotificationSettingsDataImpl(
    messages: (messages == _detectDefaultValueInCopyWith ? this.messages : messages) as bool?,
    likes: (likes == _detectDefaultValueInCopyWith ? this.likes : likes) as bool?,
  );
}
