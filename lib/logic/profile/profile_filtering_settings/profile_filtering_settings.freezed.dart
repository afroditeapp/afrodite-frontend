// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_filtering_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileFilteringSettingsData {
  bool get showOnlyFavorites => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileFilteringSettingsDataCopyWith<ProfileFilteringSettingsData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileFilteringSettingsDataCopyWith<$Res> {
  factory $ProfileFilteringSettingsDataCopyWith(
          ProfileFilteringSettingsData value,
          $Res Function(ProfileFilteringSettingsData) then) =
      _$ProfileFilteringSettingsDataCopyWithImpl<$Res,
          ProfileFilteringSettingsData>;
  @useResult
  $Res call({bool showOnlyFavorites});
}

/// @nodoc
class _$ProfileFilteringSettingsDataCopyWithImpl<$Res,
        $Val extends ProfileFilteringSettingsData>
    implements $ProfileFilteringSettingsDataCopyWith<$Res> {
  _$ProfileFilteringSettingsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showOnlyFavorites = null,
  }) {
    return _then(_value.copyWith(
      showOnlyFavorites: null == showOnlyFavorites
          ? _value.showOnlyFavorites
          : showOnlyFavorites // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileFilteringSettingsDataImplCopyWith<$Res>
    implements $ProfileFilteringSettingsDataCopyWith<$Res> {
  factory _$$ProfileFilteringSettingsDataImplCopyWith(
          _$ProfileFilteringSettingsDataImpl value,
          $Res Function(_$ProfileFilteringSettingsDataImpl) then) =
      __$$ProfileFilteringSettingsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showOnlyFavorites});
}

/// @nodoc
class __$$ProfileFilteringSettingsDataImplCopyWithImpl<$Res>
    extends _$ProfileFilteringSettingsDataCopyWithImpl<$Res,
        _$ProfileFilteringSettingsDataImpl>
    implements _$$ProfileFilteringSettingsDataImplCopyWith<$Res> {
  __$$ProfileFilteringSettingsDataImplCopyWithImpl(
      _$ProfileFilteringSettingsDataImpl _value,
      $Res Function(_$ProfileFilteringSettingsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showOnlyFavorites = null,
  }) {
    return _then(_$ProfileFilteringSettingsDataImpl(
      showOnlyFavorites: null == showOnlyFavorites
          ? _value.showOnlyFavorites
          : showOnlyFavorites // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProfileFilteringSettingsDataImpl
    with DiagnosticableTreeMixin
    implements _ProfileFilteringSettingsData {
  _$ProfileFilteringSettingsDataImpl({this.showOnlyFavorites = false});

  @override
  @JsonKey()
  final bool showOnlyFavorites;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFilteringSettingsData(showOnlyFavorites: $showOnlyFavorites)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileFilteringSettingsDataImpl &&
            (identical(other.showOnlyFavorites, showOnlyFavorites) ||
                other.showOnlyFavorites == showOnlyFavorites));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showOnlyFavorites);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileFilteringSettingsDataImplCopyWith<
          _$ProfileFilteringSettingsDataImpl>
      get copyWith => __$$ProfileFilteringSettingsDataImplCopyWithImpl<
          _$ProfileFilteringSettingsDataImpl>(this, _$identity);
}

abstract class _ProfileFilteringSettingsData
    implements ProfileFilteringSettingsData {
  factory _ProfileFilteringSettingsData({final bool showOnlyFavorites}) =
      _$ProfileFilteringSettingsDataImpl;

  @override
  bool get showOnlyFavorites;
  @override
  @JsonKey(ignore: true)
  _$$ProfileFilteringSettingsDataImplCopyWith<
          _$ProfileFilteringSettingsDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
