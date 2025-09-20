// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_pictures.dart';

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
final _privateConstructorErrorProfilePicturesData = UnsupportedError(
    'Private constructor ProfilePicturesData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfilePicturesData {
  PictureSelectionMode get mode => throw _privateConstructorErrorProfilePicturesData;
  ImgState get picture0 => throw _privateConstructorErrorProfilePicturesData;
  ImgState get picture1 => throw _privateConstructorErrorProfilePicturesData;
  ImgState get picture2 => throw _privateConstructorErrorProfilePicturesData;
  ImgState get picture3 => throw _privateConstructorErrorProfilePicturesData;
  PageKey? get pageKey => throw _privateConstructorErrorProfilePicturesData;

  ProfilePicturesData copyWith({
    PictureSelectionMode? mode,
    ImgState? picture0,
    ImgState? picture1,
    ImgState? picture2,
    ImgState? picture3,
    PageKey? pageKey,
  }) => throw _privateConstructorErrorProfilePicturesData;
}

/// @nodoc
abstract class _ProfilePicturesData extends ProfilePicturesData {
  const factory _ProfilePicturesData({
    PictureSelectionMode mode,
    ImgState picture0,
    ImgState picture1,
    ImgState picture2,
    ImgState picture3,
    PageKey? pageKey,
  }) = _$ProfilePicturesDataImpl;
  const _ProfilePicturesData._() : super._();
}

/// @nodoc
class _$ProfilePicturesDataImpl extends _ProfilePicturesData {
  static const PictureSelectionMode _modeDefaultValue = InitialSetupProfilePictures();
  static const ImgState _picture0DefaultValue = Add();
  static const ImgState _picture1DefaultValue = Hidden();
  static const ImgState _picture2DefaultValue = Hidden();
  static const ImgState _picture3DefaultValue = Hidden();
  
  const _$ProfilePicturesDataImpl({
    this.mode = _modeDefaultValue,
    this.picture0 = _picture0DefaultValue,
    this.picture1 = _picture1DefaultValue,
    this.picture2 = _picture2DefaultValue,
    this.picture3 = _picture3DefaultValue,
    this.pageKey,
  }) : super._();

  @override
  final PictureSelectionMode mode;
  @override
  final ImgState picture0;
  @override
  final ImgState picture1;
  @override
  final ImgState picture2;
  @override
  final ImgState picture3;
  @override
  final PageKey? pageKey;

  @override
  String toString() {
    return 'ProfilePicturesData(mode: $mode, picture0: $picture0, picture1: $picture1, picture2: $picture2, picture3: $picture3, pageKey: $pageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfilePicturesDataImpl &&
        (identical(other.mode, mode) ||
          other.mode == mode) &&
        (identical(other.picture0, picture0) ||
          other.picture0 == picture0) &&
        (identical(other.picture1, picture1) ||
          other.picture1 == picture1) &&
        (identical(other.picture2, picture2) ||
          other.picture2 == picture2) &&
        (identical(other.picture3, picture3) ||
          other.picture3 == picture3) &&
        (identical(other.pageKey, pageKey) ||
          other.pageKey == pageKey)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    mode,
    picture0,
    picture1,
    picture2,
    picture3,
    pageKey,
  );

  @override
  ProfilePicturesData copyWith({
    Object? mode,
    Object? picture0,
    Object? picture1,
    Object? picture2,
    Object? picture3,
    Object? pageKey = _detectDefaultValueInCopyWith,
  }) => _$ProfilePicturesDataImpl(
    mode: (mode ?? this.mode) as PictureSelectionMode,
    picture0: (picture0 ?? this.picture0) as ImgState,
    picture1: (picture1 ?? this.picture1) as ImgState,
    picture2: (picture2 ?? this.picture2) as ImgState,
    picture3: (picture3 ?? this.picture3) as ImgState,
    pageKey: (pageKey == _detectDefaultValueInCopyWith ? this.pageKey : pageKey) as PageKey?,
  );
}
