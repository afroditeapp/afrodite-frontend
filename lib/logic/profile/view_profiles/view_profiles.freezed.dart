// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_profiles.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ViewProfilesData {
  AccountId get accountId => throw _privateConstructorUsedError;
  Profile get profile => throw _privateConstructorUsedError;
  File get primaryProfileImage => throw _privateConstructorUsedError;
  (AccountId, int) get imgTag => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ViewProfilesDataCopyWith<ViewProfilesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewProfilesDataCopyWith<$Res> {
  factory $ViewProfilesDataCopyWith(
          ViewProfilesData value, $Res Function(ViewProfilesData) then) =
      _$ViewProfilesDataCopyWithImpl<$Res, ViewProfilesData>;
  @useResult
  $Res call(
      {AccountId accountId,
      Profile profile,
      File primaryProfileImage,
      (AccountId, int) imgTag,
      bool isFavorite});
}

/// @nodoc
class _$ViewProfilesDataCopyWithImpl<$Res, $Val extends ViewProfilesData>
    implements $ViewProfilesDataCopyWith<$Res> {
  _$ViewProfilesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? profile = null,
    Object? primaryProfileImage = null,
    Object? imgTag = null,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      primaryProfileImage: null == primaryProfileImage
          ? _value.primaryProfileImage
          : primaryProfileImage // ignore: cast_nullable_to_non_nullable
              as File,
      imgTag: null == imgTag
          ? _value.imgTag
          : imgTag // ignore: cast_nullable_to_non_nullable
              as (AccountId, int),
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViewProfilesDataImplCopyWith<$Res>
    implements $ViewProfilesDataCopyWith<$Res> {
  factory _$$ViewProfilesDataImplCopyWith(_$ViewProfilesDataImpl value,
          $Res Function(_$ViewProfilesDataImpl) then) =
      __$$ViewProfilesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AccountId accountId,
      Profile profile,
      File primaryProfileImage,
      (AccountId, int) imgTag,
      bool isFavorite});
}

/// @nodoc
class __$$ViewProfilesDataImplCopyWithImpl<$Res>
    extends _$ViewProfilesDataCopyWithImpl<$Res, _$ViewProfilesDataImpl>
    implements _$$ViewProfilesDataImplCopyWith<$Res> {
  __$$ViewProfilesDataImplCopyWithImpl(_$ViewProfilesDataImpl _value,
      $Res Function(_$ViewProfilesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? profile = null,
    Object? primaryProfileImage = null,
    Object? imgTag = null,
    Object? isFavorite = null,
  }) {
    return _then(_$ViewProfilesDataImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      primaryProfileImage: null == primaryProfileImage
          ? _value.primaryProfileImage
          : primaryProfileImage // ignore: cast_nullable_to_non_nullable
              as File,
      imgTag: null == imgTag
          ? _value.imgTag
          : imgTag // ignore: cast_nullable_to_non_nullable
              as (AccountId, int),
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ViewProfilesDataImpl
    with DiagnosticableTreeMixin
    implements _ViewProfilesData {
  _$ViewProfilesDataImpl(
      {required this.accountId,
      required this.profile,
      required this.primaryProfileImage,
      required this.imgTag,
      this.isFavorite = false});

  @override
  final AccountId accountId;
  @override
  final Profile profile;
  @override
  final File primaryProfileImage;
  @override
  final (AccountId, int) imgTag;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewProfilesData(accountId: $accountId, profile: $profile, primaryProfileImage: $primaryProfileImage, imgTag: $imgTag, isFavorite: $isFavorite)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ViewProfilesData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('profile', profile))
      ..add(DiagnosticsProperty('primaryProfileImage', primaryProfileImage))
      ..add(DiagnosticsProperty('imgTag', imgTag))
      ..add(DiagnosticsProperty('isFavorite', isFavorite));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewProfilesDataImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.primaryProfileImage, primaryProfileImage) ||
                other.primaryProfileImage == primaryProfileImage) &&
            (identical(other.imgTag, imgTag) || other.imgTag == imgTag) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, accountId, profile, primaryProfileImage, imgTag, isFavorite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewProfilesDataImplCopyWith<_$ViewProfilesDataImpl> get copyWith =>
      __$$ViewProfilesDataImplCopyWithImpl<_$ViewProfilesDataImpl>(
          this, _$identity);
}

abstract class _ViewProfilesData implements ViewProfilesData {
  factory _ViewProfilesData(
      {required final AccountId accountId,
      required final Profile profile,
      required final File primaryProfileImage,
      required final (AccountId, int) imgTag,
      final bool isFavorite}) = _$ViewProfilesDataImpl;

  @override
  AccountId get accountId;
  @override
  Profile get profile;
  @override
  File get primaryProfileImage;
  @override
  (AccountId, int) get imgTag;
  @override
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$ViewProfilesDataImplCopyWith<_$ViewProfilesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
