// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_my_profile.dart';

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
final _privateConstructorErrorEditMyProfileData = UnsupportedError(
    'Private constructor EditMyProfileData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditMyProfileData {
  int? get age => throw _privateConstructorErrorEditMyProfileData;
  String? get name => throw _privateConstructorErrorEditMyProfileData;
  String? get profileText => throw _privateConstructorErrorEditMyProfileData;
  Map<int, ProfileAttributeValueUpdate> get attributeIdAndStateMap => throw _privateConstructorErrorEditMyProfileData;
  bool get unlimitedLikes => throw _privateConstructorErrorEditMyProfileData;
  PageKey? get pageKey => throw _privateConstructorErrorEditMyProfileData;

  EditMyProfileData copyWith({
    int? age,
    String? name,
    String? profileText,
    Map<int, ProfileAttributeValueUpdate>? attributeIdAndStateMap,
    bool? unlimitedLikes,
    PageKey? pageKey,
  }) => throw _privateConstructorErrorEditMyProfileData;
}

/// @nodoc
abstract class _EditMyProfileData extends EditMyProfileData {
  factory _EditMyProfileData({
    int? age,
    String? name,
    String? profileText,
    Map<int, ProfileAttributeValueUpdate> attributeIdAndStateMap,
    bool unlimitedLikes,
    PageKey? pageKey,
  }) = _$EditMyProfileDataImpl;
  const _EditMyProfileData._() : super._();
}

/// @nodoc
class _$EditMyProfileDataImpl extends _EditMyProfileData with DiagnosticableTreeMixin {
  static const Map<int, ProfileAttributeValueUpdate> _attributeIdAndStateMapDefaultValue = {};
  static const bool _unlimitedLikesDefaultValue = false;
  
  _$EditMyProfileDataImpl({
    this.age,
    this.name,
    this.profileText,
    this.attributeIdAndStateMap = _attributeIdAndStateMapDefaultValue,
    this.unlimitedLikes = _unlimitedLikesDefaultValue,
    this.pageKey,
  }) : super._();

  @override
  final int? age;
  @override
  final String? name;
  @override
  final String? profileText;
  @override
  final Map<int, ProfileAttributeValueUpdate> attributeIdAndStateMap;
  @override
  final bool unlimitedLikes;
  @override
  final PageKey? pageKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditMyProfileData(age: $age, name: $name, profileText: $profileText, attributeIdAndStateMap: $attributeIdAndStateMap, unlimitedLikes: $unlimitedLikes, pageKey: $pageKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditMyProfileData'))
      ..add(DiagnosticsProperty('age', age))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('profileText', profileText))
      ..add(DiagnosticsProperty('attributeIdAndStateMap', attributeIdAndStateMap))
      ..add(DiagnosticsProperty('unlimitedLikes', unlimitedLikes))
      ..add(DiagnosticsProperty('pageKey', pageKey));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditMyProfileDataImpl &&
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
        (identical(other.pageKey, pageKey) ||
          other.pageKey == pageKey)
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
    pageKey,
  );

  @override
  EditMyProfileData copyWith({
    Object? age = _detectDefaultValueInCopyWith,
    Object? name = _detectDefaultValueInCopyWith,
    Object? profileText = _detectDefaultValueInCopyWith,
    Object? attributeIdAndStateMap,
    Object? unlimitedLikes,
    Object? pageKey = _detectDefaultValueInCopyWith,
  }) => _$EditMyProfileDataImpl(
    age: (age == _detectDefaultValueInCopyWith ? this.age : age) as int?,
    name: (name == _detectDefaultValueInCopyWith ? this.name : name) as String?,
    profileText: (profileText == _detectDefaultValueInCopyWith ? this.profileText : profileText) as String?,
    attributeIdAndStateMap: (attributeIdAndStateMap ?? this.attributeIdAndStateMap) as Map<int, ProfileAttributeValueUpdate>,
    unlimitedLikes: (unlimitedLikes ?? this.unlimitedLikes) as bool,
    pageKey: (pageKey == _detectDefaultValueInCopyWith ? this.pageKey : pageKey) as PageKey?,
  );
}
