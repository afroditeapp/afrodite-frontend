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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ViewProfilesData {
  ProfileEntry get profile => throw _privateConstructorUsedError;
  FavoriteState get isFavorite => throw _privateConstructorUsedError;
  ProfileActionState get profileActionState =>
      throw _privateConstructorUsedError;
  bool get isNotAvailable => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;
  bool get showLikeCompleted => throw _privateConstructorUsedError;
  bool get showRemoveLikeCompleted => throw _privateConstructorUsedError;

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
      {ProfileEntry profile,
      FavoriteState isFavorite,
      ProfileActionState profileActionState,
      bool isNotAvailable,
      bool isBlocked,
      bool showLikeCompleted,
      bool showRemoveLikeCompleted});
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
    Object? profile = null,
    Object? isFavorite = null,
    Object? profileActionState = null,
    Object? isNotAvailable = null,
    Object? isBlocked = null,
    Object? showLikeCompleted = null,
    Object? showRemoveLikeCompleted = null,
  }) {
    return _then(_value.copyWith(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileEntry,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as FavoriteState,
      profileActionState: null == profileActionState
          ? _value.profileActionState
          : profileActionState // ignore: cast_nullable_to_non_nullable
              as ProfileActionState,
      isNotAvailable: null == isNotAvailable
          ? _value.isNotAvailable
          : isNotAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      showLikeCompleted: null == showLikeCompleted
          ? _value.showLikeCompleted
          : showLikeCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      showRemoveLikeCompleted: null == showRemoveLikeCompleted
          ? _value.showRemoveLikeCompleted
          : showRemoveLikeCompleted // ignore: cast_nullable_to_non_nullable
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
      {ProfileEntry profile,
      FavoriteState isFavorite,
      ProfileActionState profileActionState,
      bool isNotAvailable,
      bool isBlocked,
      bool showLikeCompleted,
      bool showRemoveLikeCompleted});
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
    Object? profile = null,
    Object? isFavorite = null,
    Object? profileActionState = null,
    Object? isNotAvailable = null,
    Object? isBlocked = null,
    Object? showLikeCompleted = null,
    Object? showRemoveLikeCompleted = null,
  }) {
    return _then(_$ViewProfilesDataImpl(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileEntry,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as FavoriteState,
      profileActionState: null == profileActionState
          ? _value.profileActionState
          : profileActionState // ignore: cast_nullable_to_non_nullable
              as ProfileActionState,
      isNotAvailable: null == isNotAvailable
          ? _value.isNotAvailable
          : isNotAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      showLikeCompleted: null == showLikeCompleted
          ? _value.showLikeCompleted
          : showLikeCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      showRemoveLikeCompleted: null == showRemoveLikeCompleted
          ? _value.showRemoveLikeCompleted
          : showRemoveLikeCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ViewProfilesDataImpl
    with DiagnosticableTreeMixin
    implements _ViewProfilesData {
  _$ViewProfilesDataImpl(
      {required this.profile,
      this.isFavorite = const FavoriteStateIdle(false),
      this.profileActionState = ProfileActionState.like,
      this.isNotAvailable = false,
      this.isBlocked = false,
      this.showLikeCompleted = false,
      this.showRemoveLikeCompleted = false});

  @override
  final ProfileEntry profile;
  @override
  @JsonKey()
  final FavoriteState isFavorite;
  @override
  @JsonKey()
  final ProfileActionState profileActionState;
  @override
  @JsonKey()
  final bool isNotAvailable;
  @override
  @JsonKey()
  final bool isBlocked;
  @override
  @JsonKey()
  final bool showLikeCompleted;
  @override
  @JsonKey()
  final bool showRemoveLikeCompleted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewProfilesData(profile: $profile, isFavorite: $isFavorite, profileActionState: $profileActionState, isNotAvailable: $isNotAvailable, isBlocked: $isBlocked, showLikeCompleted: $showLikeCompleted, showRemoveLikeCompleted: $showRemoveLikeCompleted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ViewProfilesData'))
      ..add(DiagnosticsProperty('profile', profile))
      ..add(DiagnosticsProperty('isFavorite', isFavorite))
      ..add(DiagnosticsProperty('profileActionState', profileActionState))
      ..add(DiagnosticsProperty('isNotAvailable', isNotAvailable))
      ..add(DiagnosticsProperty('isBlocked', isBlocked))
      ..add(DiagnosticsProperty('showLikeCompleted', showLikeCompleted))
      ..add(DiagnosticsProperty(
          'showRemoveLikeCompleted', showRemoveLikeCompleted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewProfilesDataImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.profileActionState, profileActionState) ||
                other.profileActionState == profileActionState) &&
            (identical(other.isNotAvailable, isNotAvailable) ||
                other.isNotAvailable == isNotAvailable) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.showLikeCompleted, showLikeCompleted) ||
                other.showLikeCompleted == showLikeCompleted) &&
            (identical(
                    other.showRemoveLikeCompleted, showRemoveLikeCompleted) ||
                other.showRemoveLikeCompleted == showRemoveLikeCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      profile,
      isFavorite,
      profileActionState,
      isNotAvailable,
      isBlocked,
      showLikeCompleted,
      showRemoveLikeCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewProfilesDataImplCopyWith<_$ViewProfilesDataImpl> get copyWith =>
      __$$ViewProfilesDataImplCopyWithImpl<_$ViewProfilesDataImpl>(
          this, _$identity);
}

abstract class _ViewProfilesData implements ViewProfilesData {
  factory _ViewProfilesData(
      {required final ProfileEntry profile,
      final FavoriteState isFavorite,
      final ProfileActionState profileActionState,
      final bool isNotAvailable,
      final bool isBlocked,
      final bool showLikeCompleted,
      final bool showRemoveLikeCompleted}) = _$ViewProfilesDataImpl;

  @override
  ProfileEntry get profile;
  @override
  FavoriteState get isFavorite;
  @override
  ProfileActionState get profileActionState;
  @override
  bool get isNotAvailable;
  @override
  bool get isBlocked;
  @override
  bool get showLikeCompleted;
  @override
  bool get showRemoveLikeCompleted;
  @override
  @JsonKey(ignore: true)
  _$$ViewProfilesDataImplCopyWith<_$ViewProfilesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
