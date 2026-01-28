// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_settings.dart';

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
final _privateConstructorErrorPrivacySettingsData = UnsupportedError(
    'Private constructor PrivacySettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$PrivacySettingsData {
  UpdateState get updateState => throw _privateConstructorErrorPrivacySettingsData;
  bool get messageStateSeen => throw _privateConstructorErrorPrivacySettingsData;
  bool get typingIndicator => throw _privateConstructorErrorPrivacySettingsData;
  bool get lastSeenTime => throw _privateConstructorErrorPrivacySettingsData;
  bool get onlineStatus => throw _privateConstructorErrorPrivacySettingsData;
  bool get profilePrivacyLoading => throw _privateConstructorErrorPrivacySettingsData;
  bool get profilePrivacyLoadError => throw _privateConstructorErrorPrivacySettingsData;
  EditedPrivacySettingsData get edited => throw _privateConstructorErrorPrivacySettingsData;

  PrivacySettingsData copyWith({
    UpdateState? updateState,
    bool? messageStateSeen,
    bool? typingIndicator,
    bool? lastSeenTime,
    bool? onlineStatus,
    bool? profilePrivacyLoading,
    bool? profilePrivacyLoadError,
    EditedPrivacySettingsData? edited,
  }) => throw _privateConstructorErrorPrivacySettingsData;
}

/// @nodoc
abstract class _PrivacySettingsData extends PrivacySettingsData {
  factory _PrivacySettingsData({
    UpdateState updateState,
    bool messageStateSeen,
    bool typingIndicator,
    bool lastSeenTime,
    bool onlineStatus,
    bool profilePrivacyLoading,
    bool profilePrivacyLoadError,
    required EditedPrivacySettingsData edited,
  }) = _$PrivacySettingsDataImpl;
  _PrivacySettingsData._() : super._();
}

/// @nodoc
class _$PrivacySettingsDataImpl extends _PrivacySettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _messageStateSeenDefaultValue = false;
  static const bool _typingIndicatorDefaultValue = false;
  static const bool _lastSeenTimeDefaultValue = false;
  static const bool _onlineStatusDefaultValue = false;
  static const bool _profilePrivacyLoadingDefaultValue = false;
  static const bool _profilePrivacyLoadErrorDefaultValue = false;
  
  _$PrivacySettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.messageStateSeen = _messageStateSeenDefaultValue,
    this.typingIndicator = _typingIndicatorDefaultValue,
    this.lastSeenTime = _lastSeenTimeDefaultValue,
    this.onlineStatus = _onlineStatusDefaultValue,
    this.profilePrivacyLoading = _profilePrivacyLoadingDefaultValue,
    this.profilePrivacyLoadError = _profilePrivacyLoadErrorDefaultValue,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool messageStateSeen;
  @override
  final bool typingIndicator;
  @override
  final bool lastSeenTime;
  @override
  final bool onlineStatus;
  @override
  final bool profilePrivacyLoading;
  @override
  final bool profilePrivacyLoadError;
  @override
  final EditedPrivacySettingsData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrivacySettingsData(updateState: $updateState, messageStateSeen: $messageStateSeen, typingIndicator: $typingIndicator, lastSeenTime: $lastSeenTime, onlineStatus: $onlineStatus, profilePrivacyLoading: $profilePrivacyLoading, profilePrivacyLoadError: $profilePrivacyLoadError, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrivacySettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('messageStateSeen', messageStateSeen))
      ..add(DiagnosticsProperty('typingIndicator', typingIndicator))
      ..add(DiagnosticsProperty('lastSeenTime', lastSeenTime))
      ..add(DiagnosticsProperty('onlineStatus', onlineStatus))
      ..add(DiagnosticsProperty('profilePrivacyLoading', profilePrivacyLoading))
      ..add(DiagnosticsProperty('profilePrivacyLoadError', profilePrivacyLoadError))
      ..add(DiagnosticsProperty('edited', edited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$PrivacySettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.messageStateSeen, messageStateSeen) ||
          other.messageStateSeen == messageStateSeen) &&
        (identical(other.typingIndicator, typingIndicator) ||
          other.typingIndicator == typingIndicator) &&
        (identical(other.lastSeenTime, lastSeenTime) ||
          other.lastSeenTime == lastSeenTime) &&
        (identical(other.onlineStatus, onlineStatus) ||
          other.onlineStatus == onlineStatus) &&
        (identical(other.profilePrivacyLoading, profilePrivacyLoading) ||
          other.profilePrivacyLoading == profilePrivacyLoading) &&
        (identical(other.profilePrivacyLoadError, profilePrivacyLoadError) ||
          other.profilePrivacyLoadError == profilePrivacyLoadError) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    messageStateSeen,
    typingIndicator,
    lastSeenTime,
    onlineStatus,
    profilePrivacyLoading,
    profilePrivacyLoadError,
    edited,
  );

  @override
  PrivacySettingsData copyWith({
    Object? updateState,
    Object? messageStateSeen,
    Object? typingIndicator,
    Object? lastSeenTime,
    Object? onlineStatus,
    Object? profilePrivacyLoading,
    Object? profilePrivacyLoadError,
    Object? edited,
  }) => _$PrivacySettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    messageStateSeen: (messageStateSeen ?? this.messageStateSeen) as bool,
    typingIndicator: (typingIndicator ?? this.typingIndicator) as bool,
    lastSeenTime: (lastSeenTime ?? this.lastSeenTime) as bool,
    onlineStatus: (onlineStatus ?? this.onlineStatus) as bool,
    profilePrivacyLoading: (profilePrivacyLoading ?? this.profilePrivacyLoading) as bool,
    profilePrivacyLoadError: (profilePrivacyLoadError ?? this.profilePrivacyLoadError) as bool,
    edited: (edited ?? this.edited) as EditedPrivacySettingsData,
  );
}

/// @nodoc
final _privateConstructorErrorEditedPrivacySettingsData = UnsupportedError(
    'Private constructor EditedPrivacySettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedPrivacySettingsData {
  bool? get messageStateSeen => throw _privateConstructorErrorEditedPrivacySettingsData;
  bool? get typingIndicator => throw _privateConstructorErrorEditedPrivacySettingsData;
  bool? get lastSeenTime => throw _privateConstructorErrorEditedPrivacySettingsData;
  bool? get onlineStatus => throw _privateConstructorErrorEditedPrivacySettingsData;

  EditedPrivacySettingsData copyWith({
    bool? messageStateSeen,
    bool? typingIndicator,
    bool? lastSeenTime,
    bool? onlineStatus,
  }) => throw _privateConstructorErrorEditedPrivacySettingsData;
}

/// @nodoc
abstract class _EditedPrivacySettingsData extends EditedPrivacySettingsData {
  factory _EditedPrivacySettingsData({
    bool? messageStateSeen,
    bool? typingIndicator,
    bool? lastSeenTime,
    bool? onlineStatus,
  }) = _$EditedPrivacySettingsDataImpl;
  _EditedPrivacySettingsData._() : super._();
}

/// @nodoc
class _$EditedPrivacySettingsDataImpl extends _EditedPrivacySettingsData with DiagnosticableTreeMixin {
  _$EditedPrivacySettingsDataImpl({
    this.messageStateSeen,
    this.typingIndicator,
    this.lastSeenTime,
    this.onlineStatus,
  }) : super._();

  @override
  final bool? messageStateSeen;
  @override
  final bool? typingIndicator;
  @override
  final bool? lastSeenTime;
  @override
  final bool? onlineStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedPrivacySettingsData(messageStateSeen: $messageStateSeen, typingIndicator: $typingIndicator, lastSeenTime: $lastSeenTime, onlineStatus: $onlineStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedPrivacySettingsData'))
      ..add(DiagnosticsProperty('messageStateSeen', messageStateSeen))
      ..add(DiagnosticsProperty('typingIndicator', typingIndicator))
      ..add(DiagnosticsProperty('lastSeenTime', lastSeenTime))
      ..add(DiagnosticsProperty('onlineStatus', onlineStatus));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedPrivacySettingsDataImpl &&
        (identical(other.messageStateSeen, messageStateSeen) ||
          other.messageStateSeen == messageStateSeen) &&
        (identical(other.typingIndicator, typingIndicator) ||
          other.typingIndicator == typingIndicator) &&
        (identical(other.lastSeenTime, lastSeenTime) ||
          other.lastSeenTime == lastSeenTime) &&
        (identical(other.onlineStatus, onlineStatus) ||
          other.onlineStatus == onlineStatus)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messageStateSeen,
    typingIndicator,
    lastSeenTime,
    onlineStatus,
  );

  @override
  EditedPrivacySettingsData copyWith({
    Object? messageStateSeen = _detectDefaultValueInCopyWith,
    Object? typingIndicator = _detectDefaultValueInCopyWith,
    Object? lastSeenTime = _detectDefaultValueInCopyWith,
    Object? onlineStatus = _detectDefaultValueInCopyWith,
  }) => _$EditedPrivacySettingsDataImpl(
    messageStateSeen: (messageStateSeen == _detectDefaultValueInCopyWith ? this.messageStateSeen : messageStateSeen) as bool?,
    typingIndicator: (typingIndicator == _detectDefaultValueInCopyWith ? this.typingIndicator : typingIndicator) as bool?,
    lastSeenTime: (lastSeenTime == _detectDefaultValueInCopyWith ? this.lastSeenTime : lastSeenTime) as bool?,
    onlineStatus: (onlineStatus == _detectDefaultValueInCopyWith ? this.onlineStatus : onlineStatus) as bool?,
  );
}
