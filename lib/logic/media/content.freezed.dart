// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContentData {
  CurrentProfileContent? get content => throw _privateConstructorUsedError;
  ContentId? get securityContent => throw _privateConstructorUsedError;
  PendingProfileContentInternal? get pendingContent =>
      throw _privateConstructorUsedError;
  ContentId? get pendingSecurityContent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContentDataCopyWith<ContentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentDataCopyWith<$Res> {
  factory $ContentDataCopyWith(
          ContentData value, $Res Function(ContentData) then) =
      _$ContentDataCopyWithImpl<$Res, ContentData>;
  @useResult
  $Res call(
      {CurrentProfileContent? content,
      ContentId? securityContent,
      PendingProfileContentInternal? pendingContent,
      ContentId? pendingSecurityContent});
}

/// @nodoc
class _$ContentDataCopyWithImpl<$Res, $Val extends ContentData>
    implements $ContentDataCopyWith<$Res> {
  _$ContentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? securityContent = freezed,
    Object? pendingContent = freezed,
    Object? pendingSecurityContent = freezed,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as CurrentProfileContent?,
      securityContent: freezed == securityContent
          ? _value.securityContent
          : securityContent // ignore: cast_nullable_to_non_nullable
              as ContentId?,
      pendingContent: freezed == pendingContent
          ? _value.pendingContent
          : pendingContent // ignore: cast_nullable_to_non_nullable
              as PendingProfileContentInternal?,
      pendingSecurityContent: freezed == pendingSecurityContent
          ? _value.pendingSecurityContent
          : pendingSecurityContent // ignore: cast_nullable_to_non_nullable
              as ContentId?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentDataImplCopyWith<$Res>
    implements $ContentDataCopyWith<$Res> {
  factory _$$ContentDataImplCopyWith(
          _$ContentDataImpl value, $Res Function(_$ContentDataImpl) then) =
      __$$ContentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CurrentProfileContent? content,
      ContentId? securityContent,
      PendingProfileContentInternal? pendingContent,
      ContentId? pendingSecurityContent});
}

/// @nodoc
class __$$ContentDataImplCopyWithImpl<$Res>
    extends _$ContentDataCopyWithImpl<$Res, _$ContentDataImpl>
    implements _$$ContentDataImplCopyWith<$Res> {
  __$$ContentDataImplCopyWithImpl(
      _$ContentDataImpl _value, $Res Function(_$ContentDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? securityContent = freezed,
    Object? pendingContent = freezed,
    Object? pendingSecurityContent = freezed,
  }) {
    return _then(_$ContentDataImpl(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as CurrentProfileContent?,
      securityContent: freezed == securityContent
          ? _value.securityContent
          : securityContent // ignore: cast_nullable_to_non_nullable
              as ContentId?,
      pendingContent: freezed == pendingContent
          ? _value.pendingContent
          : pendingContent // ignore: cast_nullable_to_non_nullable
              as PendingProfileContentInternal?,
      pendingSecurityContent: freezed == pendingSecurityContent
          ? _value.pendingSecurityContent
          : pendingSecurityContent // ignore: cast_nullable_to_non_nullable
              as ContentId?,
    ));
  }
}

/// @nodoc

class _$ContentDataImpl extends _ContentData {
  _$ContentDataImpl(
      {this.content,
      this.securityContent,
      this.pendingContent,
      this.pendingSecurityContent})
      : super._();

  @override
  final CurrentProfileContent? content;
  @override
  final ContentId? securityContent;
  @override
  final PendingProfileContentInternal? pendingContent;
  @override
  final ContentId? pendingSecurityContent;

  @override
  String toString() {
    return 'ContentData(content: $content, securityContent: $securityContent, pendingContent: $pendingContent, pendingSecurityContent: $pendingSecurityContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentDataImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.securityContent, securityContent) ||
                other.securityContent == securityContent) &&
            (identical(other.pendingContent, pendingContent) ||
                other.pendingContent == pendingContent) &&
            (identical(other.pendingSecurityContent, pendingSecurityContent) ||
                other.pendingSecurityContent == pendingSecurityContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, securityContent,
      pendingContent, pendingSecurityContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentDataImplCopyWith<_$ContentDataImpl> get copyWith =>
      __$$ContentDataImplCopyWithImpl<_$ContentDataImpl>(this, _$identity);
}

abstract class _ContentData extends ContentData {
  factory _ContentData(
      {final CurrentProfileContent? content,
      final ContentId? securityContent,
      final PendingProfileContentInternal? pendingContent,
      final ContentId? pendingSecurityContent}) = _$ContentDataImpl;
  _ContentData._() : super._();

  @override
  CurrentProfileContent? get content;
  @override
  ContentId? get securityContent;
  @override
  PendingProfileContentInternal? get pendingContent;
  @override
  ContentId? get pendingSecurityContent;
  @override
  @JsonKey(ignore: true)
  _$$ContentDataImplCopyWith<_$ContentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
