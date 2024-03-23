// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_pictures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfilePicturesData {
  PictureSelectionMode get mode => throw _privateConstructorUsedError;
  ImgState get picture0 => throw _privateConstructorUsedError;
  ImgState get picture1 => throw _privateConstructorUsedError;
  ImgState get picture2 => throw _privateConstructorUsedError;
  ImgState get picture3 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfilePicturesDataCopyWith<ProfilePicturesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfilePicturesDataCopyWith<$Res> {
  factory $ProfilePicturesDataCopyWith(
          ProfilePicturesData value, $Res Function(ProfilePicturesData) then) =
      _$ProfilePicturesDataCopyWithImpl<$Res, ProfilePicturesData>;
  @useResult
  $Res call(
      {PictureSelectionMode mode,
      ImgState picture0,
      ImgState picture1,
      ImgState picture2,
      ImgState picture3});
}

/// @nodoc
class _$ProfilePicturesDataCopyWithImpl<$Res, $Val extends ProfilePicturesData>
    implements $ProfilePicturesDataCopyWith<$Res> {
  _$ProfilePicturesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? picture0 = null,
    Object? picture1 = null,
    Object? picture2 = null,
    Object? picture3 = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PictureSelectionMode,
      picture0: null == picture0
          ? _value.picture0
          : picture0 // ignore: cast_nullable_to_non_nullable
              as ImgState,
      picture1: null == picture1
          ? _value.picture1
          : picture1 // ignore: cast_nullable_to_non_nullable
              as ImgState,
      picture2: null == picture2
          ? _value.picture2
          : picture2 // ignore: cast_nullable_to_non_nullable
              as ImgState,
      picture3: null == picture3
          ? _value.picture3
          : picture3 // ignore: cast_nullable_to_non_nullable
              as ImgState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfilePicturesDataImplCopyWith<$Res>
    implements $ProfilePicturesDataCopyWith<$Res> {
  factory _$$ProfilePicturesDataImplCopyWith(_$ProfilePicturesDataImpl value,
          $Res Function(_$ProfilePicturesDataImpl) then) =
      __$$ProfilePicturesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PictureSelectionMode mode,
      ImgState picture0,
      ImgState picture1,
      ImgState picture2,
      ImgState picture3});
}

/// @nodoc
class __$$ProfilePicturesDataImplCopyWithImpl<$Res>
    extends _$ProfilePicturesDataCopyWithImpl<$Res, _$ProfilePicturesDataImpl>
    implements _$$ProfilePicturesDataImplCopyWith<$Res> {
  __$$ProfilePicturesDataImplCopyWithImpl(_$ProfilePicturesDataImpl _value,
      $Res Function(_$ProfilePicturesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? picture0 = null,
    Object? picture1 = null,
    Object? picture2 = null,
    Object? picture3 = null,
  }) {
    return _then(_$ProfilePicturesDataImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PictureSelectionMode,
      picture0: null == picture0
          ? _value.picture0
          : picture0 // ignore: cast_nullable_to_non_nullable
              as ImgState,
      picture1: null == picture1
          ? _value.picture1
          : picture1 // ignore: cast_nullable_to_non_nullable
              as ImgState,
      picture2: null == picture2
          ? _value.picture2
          : picture2 // ignore: cast_nullable_to_non_nullable
              as ImgState,
      picture3: null == picture3
          ? _value.picture3
          : picture3 // ignore: cast_nullable_to_non_nullable
              as ImgState,
    ));
  }
}

/// @nodoc

class _$ProfilePicturesDataImpl extends _ProfilePicturesData {
  const _$ProfilePicturesDataImpl(
      {this.mode = const InitialSetupProfilePictures(),
      this.picture0 = const Add(),
      this.picture1 = const Hidden(),
      this.picture2 = const Hidden(),
      this.picture3 = const Hidden()})
      : super._();

  @override
  @JsonKey()
  final PictureSelectionMode mode;
  @override
  @JsonKey()
  final ImgState picture0;
  @override
  @JsonKey()
  final ImgState picture1;
  @override
  @JsonKey()
  final ImgState picture2;
  @override
  @JsonKey()
  final ImgState picture3;

  @override
  String toString() {
    return 'ProfilePicturesData(mode: $mode, picture0: $picture0, picture1: $picture1, picture2: $picture2, picture3: $picture3)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfilePicturesDataImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.picture0, picture0) ||
                other.picture0 == picture0) &&
            (identical(other.picture1, picture1) ||
                other.picture1 == picture1) &&
            (identical(other.picture2, picture2) ||
                other.picture2 == picture2) &&
            (identical(other.picture3, picture3) ||
                other.picture3 == picture3));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, mode, picture0, picture1, picture2, picture3);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfilePicturesDataImplCopyWith<_$ProfilePicturesDataImpl> get copyWith =>
      __$$ProfilePicturesDataImplCopyWithImpl<_$ProfilePicturesDataImpl>(
          this, _$identity);
}

abstract class _ProfilePicturesData extends ProfilePicturesData {
  const factory _ProfilePicturesData(
      {final PictureSelectionMode mode,
      final ImgState picture0,
      final ImgState picture1,
      final ImgState picture2,
      final ImgState picture3}) = _$ProfilePicturesDataImpl;
  const _ProfilePicturesData._() : super._();

  @override
  PictureSelectionMode get mode;
  @override
  ImgState get picture0;
  @override
  ImgState get picture1;
  @override
  ImgState get picture2;
  @override
  ImgState get picture3;
  @override
  @JsonKey(ignore: true)
  _$$ProfilePicturesDataImplCopyWith<_$ProfilePicturesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
