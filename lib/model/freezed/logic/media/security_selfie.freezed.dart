// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_selfie.dart';

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
final _privateConstructorErrorSecuritySelfieData = UnsupportedError(
    'Private constructor SecuritySelfieData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SecuritySelfieData {
  MyContent? get securityContent => throw _privateConstructorErrorSecuritySelfieData;
  DataConsentSettings? get dataConsentSettings => throw _privateConstructorErrorSecuritySelfieData;
  UpdateState get updateState => throw _privateConstructorErrorSecuritySelfieData;
  EditedSecuritySelfieData get edited => throw _privateConstructorErrorSecuritySelfieData;

  SecuritySelfieData copyWith({
    MyContent? securityContent,
    DataConsentSettings? dataConsentSettings,
    UpdateState? updateState,
    EditedSecuritySelfieData? edited,
  }) => throw _privateConstructorErrorSecuritySelfieData;
}

/// @nodoc
abstract class _SecuritySelfieData extends SecuritySelfieData {
  factory _SecuritySelfieData({
    MyContent? securityContent,
    DataConsentSettings? dataConsentSettings,
    UpdateState updateState,
    required EditedSecuritySelfieData edited,
  }) = _$SecuritySelfieDataImpl;
  const _SecuritySelfieData._() : super._();
}

/// @nodoc
class _$SecuritySelfieDataImpl extends _SecuritySelfieData {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();

  _$SecuritySelfieDataImpl({
    this.securityContent,
    this.dataConsentSettings,
    this.updateState = _updateStateDefaultValue,
    required this.edited,
  }) : super._();

  @override
  final MyContent? securityContent;
  @override
  final DataConsentSettings? dataConsentSettings;
  @override
  final UpdateState updateState;
  @override
  final EditedSecuritySelfieData edited;

  @override
  String toString() {
    return 'SecuritySelfieData(securityContent: $securityContent, dataConsentSettings: $dataConsentSettings, updateState: $updateState, edited: $edited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SecuritySelfieDataImpl &&
        (identical(other.securityContent, securityContent) ||
          other.securityContent == securityContent) &&
        (identical(other.dataConsentSettings, dataConsentSettings) ||
          other.dataConsentSettings == dataConsentSettings) &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    securityContent,
    dataConsentSettings,
    updateState,
    edited,
  );

  @override
  SecuritySelfieData copyWith({
    Object? securityContent = _detectDefaultValueInCopyWith,
    Object? dataConsentSettings = _detectDefaultValueInCopyWith,
    Object? updateState,
    Object? edited,
  }) => _$SecuritySelfieDataImpl(
    securityContent: (securityContent == _detectDefaultValueInCopyWith ? this.securityContent : securityContent) as MyContent?,
    dataConsentSettings: (dataConsentSettings == _detectDefaultValueInCopyWith ? this.dataConsentSettings : dataConsentSettings) as DataConsentSettings?,
    updateState: (updateState ?? this.updateState) as UpdateState,
    edited: (edited ?? this.edited) as EditedSecuritySelfieData,
  );
}

/// @nodoc
final _privateConstructorErrorEditedSecuritySelfieData = UnsupportedError(
    'Private constructor EditedSecuritySelfieData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedSecuritySelfieData {
  EditValue<AccountImageId> get securityContent => throw _privateConstructorErrorEditedSecuritySelfieData;
  bool? get allowFaceVerification => throw _privateConstructorErrorEditedSecuritySelfieData;

  EditedSecuritySelfieData copyWith({
    EditValue<AccountImageId>? securityContent,
    bool? allowFaceVerification,
  }) => throw _privateConstructorErrorEditedSecuritySelfieData;
}

/// @nodoc
abstract class _EditedSecuritySelfieData extends EditedSecuritySelfieData {
  factory _EditedSecuritySelfieData({
    EditValue<AccountImageId> securityContent,
    bool? allowFaceVerification,
  }) = _$EditedSecuritySelfieDataImpl;
  const _EditedSecuritySelfieData._() : super._();
}

/// @nodoc
class _$EditedSecuritySelfieDataImpl extends _EditedSecuritySelfieData {
  static const EditValue<AccountImageId> _securityContentDefaultValue = NoEdit();

  _$EditedSecuritySelfieDataImpl({
    this.securityContent = _securityContentDefaultValue,
    this.allowFaceVerification,
  }) : super._();

  @override
  final EditValue<AccountImageId> securityContent;
  @override
  final bool? allowFaceVerification;

  @override
  String toString() {
    return 'EditedSecuritySelfieData(securityContent: $securityContent, allowFaceVerification: $allowFaceVerification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedSecuritySelfieDataImpl &&
        (identical(other.securityContent, securityContent) ||
          other.securityContent == securityContent) &&
        (identical(other.allowFaceVerification, allowFaceVerification) ||
          other.allowFaceVerification == allowFaceVerification)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    securityContent,
    allowFaceVerification,
  );

  @override
  EditedSecuritySelfieData copyWith({
    Object? securityContent,
    Object? allowFaceVerification = _detectDefaultValueInCopyWith,
  }) => _$EditedSecuritySelfieDataImpl(
    securityContent: (securityContent ?? this.securityContent) as EditValue<AccountImageId>,
    allowFaceVerification: (allowFaceVerification == _detectDefaultValueInCopyWith ? this.allowFaceVerification : allowFaceVerification) as bool?,
  );
}
