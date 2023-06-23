// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_moderation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageModerationData {
  ImageModerationStatus get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageModerationDataCopyWith<ImageModerationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageModerationDataCopyWith<$Res> {
  factory $ImageModerationDataCopyWith(
          ImageModerationData value, $Res Function(ImageModerationData) then) =
      _$ImageModerationDataCopyWithImpl<$Res, ImageModerationData>;
  @useResult
  $Res call({ImageModerationStatus state});
}

/// @nodoc
class _$ImageModerationDataCopyWithImpl<$Res, $Val extends ImageModerationData>
    implements $ImageModerationDataCopyWith<$Res> {
  _$ImageModerationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ImageModerationStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageModerationDataCopyWith<$Res>
    implements $ImageModerationDataCopyWith<$Res> {
  factory _$$_ImageModerationDataCopyWith(_$_ImageModerationData value,
          $Res Function(_$_ImageModerationData) then) =
      __$$_ImageModerationDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ImageModerationStatus state});
}

/// @nodoc
class __$$_ImageModerationDataCopyWithImpl<$Res>
    extends _$ImageModerationDataCopyWithImpl<$Res, _$_ImageModerationData>
    implements _$$_ImageModerationDataCopyWith<$Res> {
  __$$_ImageModerationDataCopyWithImpl(_$_ImageModerationData _value,
      $Res Function(_$_ImageModerationData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$_ImageModerationData(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ImageModerationStatus,
    ));
  }
}

/// @nodoc

class _$_ImageModerationData
    with DiagnosticableTreeMixin
    implements _ImageModerationData {
  _$_ImageModerationData({this.state = ImageModerationStatus.loading});

  @override
  @JsonKey()
  final ImageModerationStatus state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageModerationData(state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageModerationData'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageModerationData &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageModerationDataCopyWith<_$_ImageModerationData> get copyWith =>
      __$$_ImageModerationDataCopyWithImpl<_$_ImageModerationData>(
          this, _$identity);
}

abstract class _ImageModerationData implements ImageModerationData {
  factory _ImageModerationData({final ImageModerationStatus state}) =
      _$_ImageModerationData;

  @override
  ImageModerationStatus get state;
  @override
  @JsonKey(ignore: true)
  _$$_ImageModerationDataCopyWith<_$_ImageModerationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ModerationEntry {
  ContentId? get securitySelfie => throw _privateConstructorUsedError;
  ContentId get target => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModerationEntryCopyWith<ModerationEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModerationEntryCopyWith<$Res> {
  factory $ModerationEntryCopyWith(
          ModerationEntry value, $Res Function(ModerationEntry) then) =
      _$ModerationEntryCopyWithImpl<$Res, ModerationEntry>;
  @useResult
  $Res call({ContentId? securitySelfie, ContentId target, bool? status});
}

/// @nodoc
class _$ModerationEntryCopyWithImpl<$Res, $Val extends ModerationEntry>
    implements $ModerationEntryCopyWith<$Res> {
  _$ModerationEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? securitySelfie = freezed,
    Object? target = null,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      securitySelfie: freezed == securitySelfie
          ? _value.securitySelfie
          : securitySelfie // ignore: cast_nullable_to_non_nullable
              as ContentId?,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as ContentId,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModerationEntryCopyWith<$Res>
    implements $ModerationEntryCopyWith<$Res> {
  factory _$$_ModerationEntryCopyWith(
          _$_ModerationEntry value, $Res Function(_$_ModerationEntry) then) =
      __$$_ModerationEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ContentId? securitySelfie, ContentId target, bool? status});
}

/// @nodoc
class __$$_ModerationEntryCopyWithImpl<$Res>
    extends _$ModerationEntryCopyWithImpl<$Res, _$_ModerationEntry>
    implements _$$_ModerationEntryCopyWith<$Res> {
  __$$_ModerationEntryCopyWithImpl(
      _$_ModerationEntry _value, $Res Function(_$_ModerationEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? securitySelfie = freezed,
    Object? target = null,
    Object? status = freezed,
  }) {
    return _then(_$_ModerationEntry(
      securitySelfie: freezed == securitySelfie
          ? _value.securitySelfie
          : securitySelfie // ignore: cast_nullable_to_non_nullable
              as ContentId?,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as ContentId,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_ModerationEntry
    with DiagnosticableTreeMixin
    implements _ModerationEntry {
  _$_ModerationEntry({this.securitySelfie, required this.target, this.status});

  @override
  final ContentId? securitySelfie;
  @override
  final ContentId target;
  @override
  final bool? status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ModerationEntry(securitySelfie: $securitySelfie, target: $target, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ModerationEntry'))
      ..add(DiagnosticsProperty('securitySelfie', securitySelfie))
      ..add(DiagnosticsProperty('target', target))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModerationEntry &&
            (identical(other.securitySelfie, securitySelfie) ||
                other.securitySelfie == securitySelfie) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, securitySelfie, target, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModerationEntryCopyWith<_$_ModerationEntry> get copyWith =>
      __$$_ModerationEntryCopyWithImpl<_$_ModerationEntry>(this, _$identity);
}

abstract class _ModerationEntry implements ModerationEntry {
  factory _ModerationEntry(
      {final ContentId? securitySelfie,
      required final ContentId target,
      final bool? status}) = _$_ModerationEntry;

  @override
  ContentId? get securitySelfie;
  @override
  ContentId get target;
  @override
  bool? get status;
  @override
  @JsonKey(ignore: true)
  _$$_ModerationEntryCopyWith<_$_ModerationEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ModerationRequestEntry {
  bool? get imageStatus1 => throw _privateConstructorUsedError;
  bool? get imageStatus2 => throw _privateConstructorUsedError;
  Moderation get m => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModerationRequestEntryCopyWith<ModerationRequestEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModerationRequestEntryCopyWith<$Res> {
  factory $ModerationRequestEntryCopyWith(ModerationRequestEntry value,
          $Res Function(ModerationRequestEntry) then) =
      _$ModerationRequestEntryCopyWithImpl<$Res, ModerationRequestEntry>;
  @useResult
  $Res call({bool? imageStatus1, bool? imageStatus2, Moderation m});
}

/// @nodoc
class _$ModerationRequestEntryCopyWithImpl<$Res,
        $Val extends ModerationRequestEntry>
    implements $ModerationRequestEntryCopyWith<$Res> {
  _$ModerationRequestEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageStatus1 = freezed,
    Object? imageStatus2 = freezed,
    Object? m = null,
  }) {
    return _then(_value.copyWith(
      imageStatus1: freezed == imageStatus1
          ? _value.imageStatus1
          : imageStatus1 // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageStatus2: freezed == imageStatus2
          ? _value.imageStatus2
          : imageStatus2 // ignore: cast_nullable_to_non_nullable
              as bool?,
      m: null == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as Moderation,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModerationRequestEntryCopyWith<$Res>
    implements $ModerationRequestEntryCopyWith<$Res> {
  factory _$$_ModerationRequestEntryCopyWith(_$_ModerationRequestEntry value,
          $Res Function(_$_ModerationRequestEntry) then) =
      __$$_ModerationRequestEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? imageStatus1, bool? imageStatus2, Moderation m});
}

/// @nodoc
class __$$_ModerationRequestEntryCopyWithImpl<$Res>
    extends _$ModerationRequestEntryCopyWithImpl<$Res,
        _$_ModerationRequestEntry>
    implements _$$_ModerationRequestEntryCopyWith<$Res> {
  __$$_ModerationRequestEntryCopyWithImpl(_$_ModerationRequestEntry _value,
      $Res Function(_$_ModerationRequestEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageStatus1 = freezed,
    Object? imageStatus2 = freezed,
    Object? m = null,
  }) {
    return _then(_$_ModerationRequestEntry(
      imageStatus1: freezed == imageStatus1
          ? _value.imageStatus1
          : imageStatus1 // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageStatus2: freezed == imageStatus2
          ? _value.imageStatus2
          : imageStatus2 // ignore: cast_nullable_to_non_nullable
              as bool?,
      m: null == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as Moderation,
    ));
  }
}

/// @nodoc

class _$_ModerationRequestEntry
    with DiagnosticableTreeMixin
    implements _ModerationRequestEntry {
  _$_ModerationRequestEntry(
      {this.imageStatus1, this.imageStatus2, required this.m});

  @override
  final bool? imageStatus1;
  @override
  final bool? imageStatus2;
  @override
  final Moderation m;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ModerationRequestEntry(imageStatus1: $imageStatus1, imageStatus2: $imageStatus2, m: $m)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ModerationRequestEntry'))
      ..add(DiagnosticsProperty('imageStatus1', imageStatus1))
      ..add(DiagnosticsProperty('imageStatus2', imageStatus2))
      ..add(DiagnosticsProperty('m', m));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModerationRequestEntry &&
            (identical(other.imageStatus1, imageStatus1) ||
                other.imageStatus1 == imageStatus1) &&
            (identical(other.imageStatus2, imageStatus2) ||
                other.imageStatus2 == imageStatus2) &&
            (identical(other.m, m) || other.m == m));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageStatus1, imageStatus2, m);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModerationRequestEntryCopyWith<_$_ModerationRequestEntry> get copyWith =>
      __$$_ModerationRequestEntryCopyWithImpl<_$_ModerationRequestEntry>(
          this, _$identity);
}

abstract class _ModerationRequestEntry implements ModerationRequestEntry {
  factory _ModerationRequestEntry(
      {final bool? imageStatus1,
      final bool? imageStatus2,
      required final Moderation m}) = _$_ModerationRequestEntry;

  @override
  bool? get imageStatus1;
  @override
  bool? get imageStatus2;
  @override
  Moderation get m;
  @override
  @JsonKey(ignore: true)
  _$$_ModerationRequestEntryCopyWith<_$_ModerationRequestEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
