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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$ImageModerationDataImplCopyWith<$Res>
    implements $ImageModerationDataCopyWith<$Res> {
  factory _$$ImageModerationDataImplCopyWith(_$ImageModerationDataImpl value,
          $Res Function(_$ImageModerationDataImpl) then) =
      __$$ImageModerationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ImageModerationStatus state});
}

/// @nodoc
class __$$ImageModerationDataImplCopyWithImpl<$Res>
    extends _$ImageModerationDataCopyWithImpl<$Res, _$ImageModerationDataImpl>
    implements _$$ImageModerationDataImplCopyWith<$Res> {
  __$$ImageModerationDataImplCopyWithImpl(_$ImageModerationDataImpl _value,
      $Res Function(_$ImageModerationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$ImageModerationDataImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ImageModerationStatus,
    ));
  }
}

/// @nodoc

class _$ImageModerationDataImpl
    with DiagnosticableTreeMixin
    implements _ImageModerationData {
  _$ImageModerationDataImpl({this.state = ImageModerationStatus.moderating});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageModerationDataImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageModerationDataImplCopyWith<_$ImageModerationDataImpl> get copyWith =>
      __$$ImageModerationDataImplCopyWithImpl<_$ImageModerationDataImpl>(
          this, _$identity);
}

abstract class _ImageModerationData implements ImageModerationData {
  factory _ImageModerationData({final ImageModerationStatus state}) =
      _$ImageModerationDataImpl;

  @override
  ImageModerationStatus get state;
  @override
  @JsonKey(ignore: true)
  _$$ImageModerationDataImplCopyWith<_$ImageModerationDataImpl> get copyWith =>
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
abstract class _$$ModerationEntryImplCopyWith<$Res>
    implements $ModerationEntryCopyWith<$Res> {
  factory _$$ModerationEntryImplCopyWith(_$ModerationEntryImpl value,
          $Res Function(_$ModerationEntryImpl) then) =
      __$$ModerationEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ContentId? securitySelfie, ContentId target, bool? status});
}

/// @nodoc
class __$$ModerationEntryImplCopyWithImpl<$Res>
    extends _$ModerationEntryCopyWithImpl<$Res, _$ModerationEntryImpl>
    implements _$$ModerationEntryImplCopyWith<$Res> {
  __$$ModerationEntryImplCopyWithImpl(
      _$ModerationEntryImpl _value, $Res Function(_$ModerationEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? securitySelfie = freezed,
    Object? target = null,
    Object? status = freezed,
  }) {
    return _then(_$ModerationEntryImpl(
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

class _$ModerationEntryImpl
    with DiagnosticableTreeMixin
    implements _ModerationEntry {
  _$ModerationEntryImpl(
      {this.securitySelfie, required this.target, this.status});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModerationEntryImpl &&
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
  _$$ModerationEntryImplCopyWith<_$ModerationEntryImpl> get copyWith =>
      __$$ModerationEntryImplCopyWithImpl<_$ModerationEntryImpl>(
          this, _$identity);
}

abstract class _ModerationEntry implements ModerationEntry {
  factory _ModerationEntry(
      {final ContentId? securitySelfie,
      required final ContentId target,
      final bool? status}) = _$ModerationEntryImpl;

  @override
  ContentId? get securitySelfie;
  @override
  ContentId get target;
  @override
  bool? get status;
  @override
  @JsonKey(ignore: true)
  _$$ModerationEntryImplCopyWith<_$ModerationEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
