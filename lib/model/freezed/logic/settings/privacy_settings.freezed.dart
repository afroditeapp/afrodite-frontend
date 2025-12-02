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
  bool get messageStateDelivered => throw _privateConstructorErrorPrivacySettingsData;
  bool get messageStateSent => throw _privateConstructorErrorPrivacySettingsData;
  bool get typingIndicator => throw _privateConstructorErrorPrivacySettingsData;
  EditedPrivacySettingsData get edited => throw _privateConstructorErrorPrivacySettingsData;

  PrivacySettingsData copyWith({
    UpdateState? updateState,
    bool? messageStateDelivered,
    bool? messageStateSent,
    bool? typingIndicator,
    EditedPrivacySettingsData? edited,
  }) => throw _privateConstructorErrorPrivacySettingsData;
}

/// @nodoc
abstract class _PrivacySettingsData extends PrivacySettingsData {
  factory _PrivacySettingsData({
    UpdateState updateState,
    bool messageStateDelivered,
    bool messageStateSent,
    bool typingIndicator,
    required EditedPrivacySettingsData edited,
  }) = _$PrivacySettingsDataImpl;
  _PrivacySettingsData._() : super._();
}

/// @nodoc
class _$PrivacySettingsDataImpl extends _PrivacySettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _messageStateDeliveredDefaultValue = false;
  static const bool _messageStateSentDefaultValue = false;
  static const bool _typingIndicatorDefaultValue = false;
  
  _$PrivacySettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.messageStateDelivered = _messageStateDeliveredDefaultValue,
    this.messageStateSent = _messageStateSentDefaultValue,
    this.typingIndicator = _typingIndicatorDefaultValue,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool messageStateDelivered;
  @override
  final bool messageStateSent;
  @override
  final bool typingIndicator;
  @override
  final EditedPrivacySettingsData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrivacySettingsData(updateState: $updateState, messageStateDelivered: $messageStateDelivered, messageStateSent: $messageStateSent, typingIndicator: $typingIndicator, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrivacySettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('messageStateDelivered', messageStateDelivered))
      ..add(DiagnosticsProperty('messageStateSent', messageStateSent))
      ..add(DiagnosticsProperty('typingIndicator', typingIndicator))
      ..add(DiagnosticsProperty('edited', edited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$PrivacySettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.messageStateDelivered, messageStateDelivered) ||
          other.messageStateDelivered == messageStateDelivered) &&
        (identical(other.messageStateSent, messageStateSent) ||
          other.messageStateSent == messageStateSent) &&
        (identical(other.typingIndicator, typingIndicator) ||
          other.typingIndicator == typingIndicator) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    messageStateDelivered,
    messageStateSent,
    typingIndicator,
    edited,
  );

  @override
  PrivacySettingsData copyWith({
    Object? updateState,
    Object? messageStateDelivered,
    Object? messageStateSent,
    Object? typingIndicator,
    Object? edited,
  }) => _$PrivacySettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    messageStateDelivered: (messageStateDelivered ?? this.messageStateDelivered) as bool,
    messageStateSent: (messageStateSent ?? this.messageStateSent) as bool,
    typingIndicator: (typingIndicator ?? this.typingIndicator) as bool,
    edited: (edited ?? this.edited) as EditedPrivacySettingsData,
  );
}

/// @nodoc
final _privateConstructorErrorEditedPrivacySettingsData = UnsupportedError(
    'Private constructor EditedPrivacySettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedPrivacySettingsData {
  bool? get messageStateDelivered => throw _privateConstructorErrorEditedPrivacySettingsData;
  bool? get messageStateSent => throw _privateConstructorErrorEditedPrivacySettingsData;
  bool? get typingIndicator => throw _privateConstructorErrorEditedPrivacySettingsData;

  EditedPrivacySettingsData copyWith({
    bool? messageStateDelivered,
    bool? messageStateSent,
    bool? typingIndicator,
  }) => throw _privateConstructorErrorEditedPrivacySettingsData;
}

/// @nodoc
abstract class _EditedPrivacySettingsData extends EditedPrivacySettingsData {
  factory _EditedPrivacySettingsData({
    bool? messageStateDelivered,
    bool? messageStateSent,
    bool? typingIndicator,
  }) = _$EditedPrivacySettingsDataImpl;
  _EditedPrivacySettingsData._() : super._();
}

/// @nodoc
class _$EditedPrivacySettingsDataImpl extends _EditedPrivacySettingsData with DiagnosticableTreeMixin {
  _$EditedPrivacySettingsDataImpl({
    this.messageStateDelivered,
    this.messageStateSent,
    this.typingIndicator,
  }) : super._();

  @override
  final bool? messageStateDelivered;
  @override
  final bool? messageStateSent;
  @override
  final bool? typingIndicator;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedPrivacySettingsData(messageStateDelivered: $messageStateDelivered, messageStateSent: $messageStateSent, typingIndicator: $typingIndicator)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedPrivacySettingsData'))
      ..add(DiagnosticsProperty('messageStateDelivered', messageStateDelivered))
      ..add(DiagnosticsProperty('messageStateSent', messageStateSent))
      ..add(DiagnosticsProperty('typingIndicator', typingIndicator));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedPrivacySettingsDataImpl &&
        (identical(other.messageStateDelivered, messageStateDelivered) ||
          other.messageStateDelivered == messageStateDelivered) &&
        (identical(other.messageStateSent, messageStateSent) ||
          other.messageStateSent == messageStateSent) &&
        (identical(other.typingIndicator, typingIndicator) ||
          other.typingIndicator == typingIndicator)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messageStateDelivered,
    messageStateSent,
    typingIndicator,
  );

  @override
  EditedPrivacySettingsData copyWith({
    Object? messageStateDelivered = _detectDefaultValueInCopyWith,
    Object? messageStateSent = _detectDefaultValueInCopyWith,
    Object? typingIndicator = _detectDefaultValueInCopyWith,
  }) => _$EditedPrivacySettingsDataImpl(
    messageStateDelivered: (messageStateDelivered == _detectDefaultValueInCopyWith ? this.messageStateDelivered : messageStateDelivered) as bool?,
    messageStateSent: (messageStateSent == _detectDefaultValueInCopyWith ? this.messageStateSent : messageStateSent) as bool?,
    typingIndicator: (typingIndicator == _detectDefaultValueInCopyWith ? this.typingIndicator : typingIndicator) as bool?,
  );
}
