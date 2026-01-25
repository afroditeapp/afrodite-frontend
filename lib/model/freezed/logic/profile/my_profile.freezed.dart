// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile.dart';

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
final _privateConstructorErrorMyProfileData = UnsupportedError(
    'Private constructor MyProfileData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$MyProfileData {
  UpdateState get updateState => throw _privateConstructorErrorMyProfileData;
  MyProfileEntry? get profile => throw _privateConstructorErrorMyProfileData;
  bool get loadingMyProfile => throw _privateConstructorErrorMyProfileData;
  InitialAgeInfo? get initialAgeInfo => throw _privateConstructorErrorMyProfileData;
  EditedMyProfileData get edited => throw _privateConstructorErrorMyProfileData;

  MyProfileData copyWith({
    UpdateState? updateState,
    MyProfileEntry? profile,
    bool? loadingMyProfile,
    InitialAgeInfo? initialAgeInfo,
    EditedMyProfileData? edited,
  }) => throw _privateConstructorErrorMyProfileData;
}

/// @nodoc
abstract class _MyProfileData extends MyProfileData {
  factory _MyProfileData({
    UpdateState updateState,
    MyProfileEntry? profile,
    bool loadingMyProfile,
    InitialAgeInfo? initialAgeInfo,
    required EditedMyProfileData edited,
  }) = _$MyProfileDataImpl;
  _MyProfileData._() : super._();
}

/// @nodoc
class _$MyProfileDataImpl extends _MyProfileData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _loadingMyProfileDefaultValue = false;
  
  _$MyProfileDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.profile,
    this.loadingMyProfile = _loadingMyProfileDefaultValue,
    this.initialAgeInfo,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final MyProfileEntry? profile;
  @override
  final bool loadingMyProfile;
  @override
  final InitialAgeInfo? initialAgeInfo;
  @override
  final EditedMyProfileData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyProfileData(updateState: $updateState, profile: $profile, loadingMyProfile: $loadingMyProfile, initialAgeInfo: $initialAgeInfo, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyProfileData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('profile', profile))
      ..add(DiagnosticsProperty('loadingMyProfile', loadingMyProfile))
      ..add(DiagnosticsProperty('initialAgeInfo', initialAgeInfo))
      ..add(DiagnosticsProperty('edited', edited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$MyProfileDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.profile, profile) ||
          other.profile == profile) &&
        (identical(other.loadingMyProfile, loadingMyProfile) ||
          other.loadingMyProfile == loadingMyProfile) &&
        (identical(other.initialAgeInfo, initialAgeInfo) ||
          other.initialAgeInfo == initialAgeInfo) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    profile,
    loadingMyProfile,
    initialAgeInfo,
    edited,
  );

  @override
  MyProfileData copyWith({
    Object? updateState,
    Object? profile = _detectDefaultValueInCopyWith,
    Object? loadingMyProfile,
    Object? initialAgeInfo = _detectDefaultValueInCopyWith,
    Object? edited,
  }) => _$MyProfileDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    profile: (profile == _detectDefaultValueInCopyWith ? this.profile : profile) as MyProfileEntry?,
    loadingMyProfile: (loadingMyProfile ?? this.loadingMyProfile) as bool,
    initialAgeInfo: (initialAgeInfo == _detectDefaultValueInCopyWith ? this.initialAgeInfo : initialAgeInfo) as InitialAgeInfo?,
    edited: (edited ?? this.edited) as EditedMyProfileData,
  );
}

/// @nodoc
final _privateConstructorErrorEditedMyProfileData = UnsupportedError(
    'Private constructor EditedMyProfileData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedMyProfileData {
  int? get age => throw _privateConstructorErrorEditedMyProfileData;
  String? get name => throw _privateConstructorErrorEditedMyProfileData;
  EditValue<String> get profileText => throw _privateConstructorErrorEditedMyProfileData;
  Map<int, ProfileAttributeValueUpdate>? get attributeIdAndStateMap => throw _privateConstructorErrorEditedMyProfileData;
  bool? get unlimitedLikes => throw _privateConstructorErrorEditedMyProfileData;
  EditValue<ImgState> get picture0 => throw _privateConstructorErrorEditedMyProfileData;
  EditValue<ImgState> get picture1 => throw _privateConstructorErrorEditedMyProfileData;
  EditValue<ImgState> get picture2 => throw _privateConstructorErrorEditedMyProfileData;
  EditValue<ImgState> get picture3 => throw _privateConstructorErrorEditedMyProfileData;

  EditedMyProfileData copyWith({
    int? age,
    String? name,
    EditValue<String>? profileText,
    Map<int, ProfileAttributeValueUpdate>? attributeIdAndStateMap,
    bool? unlimitedLikes,
    EditValue<ImgState>? picture0,
    EditValue<ImgState>? picture1,
    EditValue<ImgState>? picture2,
    EditValue<ImgState>? picture3,
  }) => throw _privateConstructorErrorEditedMyProfileData;
}

/// @nodoc
abstract class _EditedMyProfileData extends EditedMyProfileData {
  factory _EditedMyProfileData({
    int? age,
    String? name,
    EditValue<String> profileText,
    Map<int, ProfileAttributeValueUpdate>? attributeIdAndStateMap,
    bool? unlimitedLikes,
    EditValue<ImgState> picture0,
    EditValue<ImgState> picture1,
    EditValue<ImgState> picture2,
    EditValue<ImgState> picture3,
  }) = _$EditedMyProfileDataImpl;
  _EditedMyProfileData._() : super._();
}

/// @nodoc
class _$EditedMyProfileDataImpl extends _EditedMyProfileData with DiagnosticableTreeMixin {
  static const EditValue<String> _profileTextDefaultValue = NoEdit();
  static const EditValue<ImgState> _picture0DefaultValue = NoEdit();
  static const EditValue<ImgState> _picture1DefaultValue = NoEdit();
  static const EditValue<ImgState> _picture2DefaultValue = NoEdit();
  static const EditValue<ImgState> _picture3DefaultValue = NoEdit();
  
  _$EditedMyProfileDataImpl({
    this.age,
    this.name,
    this.profileText = _profileTextDefaultValue,
    this.attributeIdAndStateMap,
    this.unlimitedLikes,
    this.picture0 = _picture0DefaultValue,
    this.picture1 = _picture1DefaultValue,
    this.picture2 = _picture2DefaultValue,
    this.picture3 = _picture3DefaultValue,
  }) : super._();

  @override
  final int? age;
  @override
  final String? name;
  @override
  final EditValue<String> profileText;
  @override
  final Map<int, ProfileAttributeValueUpdate>? attributeIdAndStateMap;
  @override
  final bool? unlimitedLikes;
  @override
  final EditValue<ImgState> picture0;
  @override
  final EditValue<ImgState> picture1;
  @override
  final EditValue<ImgState> picture2;
  @override
  final EditValue<ImgState> picture3;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedMyProfileData(age: $age, name: $name, profileText: $profileText, attributeIdAndStateMap: $attributeIdAndStateMap, unlimitedLikes: $unlimitedLikes, picture0: $picture0, picture1: $picture1, picture2: $picture2, picture3: $picture3)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedMyProfileData'))
      ..add(DiagnosticsProperty('age', age))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('profileText', profileText))
      ..add(DiagnosticsProperty('attributeIdAndStateMap', attributeIdAndStateMap))
      ..add(DiagnosticsProperty('unlimitedLikes', unlimitedLikes))
      ..add(DiagnosticsProperty('picture0', picture0))
      ..add(DiagnosticsProperty('picture1', picture1))
      ..add(DiagnosticsProperty('picture2', picture2))
      ..add(DiagnosticsProperty('picture3', picture3));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedMyProfileDataImpl &&
        (identical(other.age, age) ||
          other.age == age) &&
        (identical(other.name, name) ||
          other.name == name) &&
        (identical(other.profileText, profileText) ||
          other.profileText == profileText) &&
        (identical(other.attributeIdAndStateMap, attributeIdAndStateMap) ||
          other.attributeIdAndStateMap == attributeIdAndStateMap) &&
        (identical(other.unlimitedLikes, unlimitedLikes) ||
          other.unlimitedLikes == unlimitedLikes) &&
        (identical(other.picture0, picture0) ||
          other.picture0 == picture0) &&
        (identical(other.picture1, picture1) ||
          other.picture1 == picture1) &&
        (identical(other.picture2, picture2) ||
          other.picture2 == picture2) &&
        (identical(other.picture3, picture3) ||
          other.picture3 == picture3)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    age,
    name,
    profileText,
    attributeIdAndStateMap,
    unlimitedLikes,
    picture0,
    picture1,
    picture2,
    picture3,
  );

  @override
  EditedMyProfileData copyWith({
    Object? age = _detectDefaultValueInCopyWith,
    Object? name = _detectDefaultValueInCopyWith,
    Object? profileText,
    Object? attributeIdAndStateMap = _detectDefaultValueInCopyWith,
    Object? unlimitedLikes = _detectDefaultValueInCopyWith,
    Object? picture0,
    Object? picture1,
    Object? picture2,
    Object? picture3,
  }) => _$EditedMyProfileDataImpl(
    age: (age == _detectDefaultValueInCopyWith ? this.age : age) as int?,
    name: (name == _detectDefaultValueInCopyWith ? this.name : name) as String?,
    profileText: (profileText ?? this.profileText) as EditValue<String>,
    attributeIdAndStateMap: (attributeIdAndStateMap == _detectDefaultValueInCopyWith ? this.attributeIdAndStateMap : attributeIdAndStateMap) as Map<int, ProfileAttributeValueUpdate>?,
    unlimitedLikes: (unlimitedLikes == _detectDefaultValueInCopyWith ? this.unlimitedLikes : unlimitedLikes) as bool?,
    picture0: (picture0 ?? this.picture0) as EditValue<ImgState>,
    picture1: (picture1 ?? this.picture1) as EditValue<ImgState>,
    picture2: (picture2 ?? this.picture2) as EditValue<ImgState>,
    picture3: (picture3 ?? this.picture3) as EditValue<ImgState>,
  );
}
