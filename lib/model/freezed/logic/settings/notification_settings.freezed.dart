// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorNotificationSettingsData = UnsupportedError(
    'Private constructor NotificationSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NotificationSettingsData {
  bool get categoryEnabledMessages => throw _privateConstructorErrorNotificationSettingsData;
  bool get categoryEnabledLikes => throw _privateConstructorErrorNotificationSettingsData;
  bool get categoryEnabledModerationRequestStatus => throw _privateConstructorErrorNotificationSettingsData;

  NotificationSettingsData copyWith({
    bool? categoryEnabledMessages,
    bool? categoryEnabledLikes,
    bool? categoryEnabledModerationRequestStatus,
  }) => throw _privateConstructorErrorNotificationSettingsData;
}

/// @nodoc
abstract class _NotificationSettingsData implements NotificationSettingsData {
  factory _NotificationSettingsData({
    bool categoryEnabledMessages,
    bool categoryEnabledLikes,
    bool categoryEnabledModerationRequestStatus,
  }) = _$NotificationSettingsDataImpl;
}

/// @nodoc
class _$NotificationSettingsDataImpl with DiagnosticableTreeMixin implements _NotificationSettingsData {
  static const bool _categoryEnabledMessagesDefaultValue = true;
  static const bool _categoryEnabledLikesDefaultValue = true;
  static const bool _categoryEnabledModerationRequestStatusDefaultValue = true;
  
  _$NotificationSettingsDataImpl({
    this.categoryEnabledMessages = _categoryEnabledMessagesDefaultValue,
    this.categoryEnabledLikes = _categoryEnabledLikesDefaultValue,
    this.categoryEnabledModerationRequestStatus = _categoryEnabledModerationRequestStatusDefaultValue,
  });

  @override
  final bool categoryEnabledMessages;
  @override
  final bool categoryEnabledLikes;
  @override
  final bool categoryEnabledModerationRequestStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationSettingsData(categoryEnabledMessages: $categoryEnabledMessages, categoryEnabledLikes: $categoryEnabledLikes, categoryEnabledModerationRequestStatus: $categoryEnabledModerationRequestStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationSettingsData'))
      ..add(DiagnosticsProperty('categoryEnabledMessages', categoryEnabledMessages))
      ..add(DiagnosticsProperty('categoryEnabledLikes', categoryEnabledLikes))
      ..add(DiagnosticsProperty('categoryEnabledModerationRequestStatus', categoryEnabledModerationRequestStatus));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NotificationSettingsDataImpl &&
        (identical(other.categoryEnabledMessages, categoryEnabledMessages) ||
          other.categoryEnabledMessages == categoryEnabledMessages) &&
        (identical(other.categoryEnabledLikes, categoryEnabledLikes) ||
          other.categoryEnabledLikes == categoryEnabledLikes) &&
        (identical(other.categoryEnabledModerationRequestStatus, categoryEnabledModerationRequestStatus) ||
          other.categoryEnabledModerationRequestStatus == categoryEnabledModerationRequestStatus)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryEnabledMessages,
    categoryEnabledLikes,
    categoryEnabledModerationRequestStatus,
  );

  @override
  NotificationSettingsData copyWith({
    Object? categoryEnabledMessages,
    Object? categoryEnabledLikes,
    Object? categoryEnabledModerationRequestStatus,
  }) => _$NotificationSettingsDataImpl(
    categoryEnabledMessages: (categoryEnabledMessages ?? this.categoryEnabledMessages) as bool,
    categoryEnabledLikes: (categoryEnabledLikes ?? this.categoryEnabledLikes) as bool,
    categoryEnabledModerationRequestStatus: (categoryEnabledModerationRequestStatus ?? this.categoryEnabledModerationRequestStatus) as bool,
  );
}
