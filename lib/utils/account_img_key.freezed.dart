// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_img_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountImgKey {
  AccountId get accountId => throw _privateConstructorUsedError;
  ContentId get contentId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountImgKeyCopyWith<AccountImgKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountImgKeyCopyWith<$Res> {
  factory $AccountImgKeyCopyWith(
          AccountImgKey value, $Res Function(AccountImgKey) then) =
      _$AccountImgKeyCopyWithImpl<$Res, AccountImgKey>;
  @useResult
  $Res call({AccountId accountId, ContentId contentId});
}

/// @nodoc
class _$AccountImgKeyCopyWithImpl<$Res, $Val extends AccountImgKey>
    implements $AccountImgKeyCopyWith<$Res> {
  _$AccountImgKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? contentId = null,
  }) {
    return _then(_value.copyWith(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as ContentId,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountImgKeyImplCopyWith<$Res>
    implements $AccountImgKeyCopyWith<$Res> {
  factory _$$AccountImgKeyImplCopyWith(
          _$AccountImgKeyImpl value, $Res Function(_$AccountImgKeyImpl) then) =
      __$$AccountImgKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AccountId accountId, ContentId contentId});
}

/// @nodoc
class __$$AccountImgKeyImplCopyWithImpl<$Res>
    extends _$AccountImgKeyCopyWithImpl<$Res, _$AccountImgKeyImpl>
    implements _$$AccountImgKeyImplCopyWith<$Res> {
  __$$AccountImgKeyImplCopyWithImpl(
      _$AccountImgKeyImpl _value, $Res Function(_$AccountImgKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? contentId = null,
  }) {
    return _then(_$AccountImgKeyImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as ContentId,
    ));
  }
}

/// @nodoc

class _$AccountImgKeyImpl
    with DiagnosticableTreeMixin
    implements _AccountImgKey {
  _$AccountImgKeyImpl({required this.accountId, required this.contentId});

  @override
  final AccountId accountId;
  @override
  final ContentId contentId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountImgKey(accountId: $accountId, contentId: $contentId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountImgKey'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('contentId', contentId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImgKeyImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId, contentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImgKeyImplCopyWith<_$AccountImgKeyImpl> get copyWith =>
      __$$AccountImgKeyImplCopyWithImpl<_$AccountImgKeyImpl>(this, _$identity);
}

abstract class _AccountImgKey implements AccountImgKey {
  factory _AccountImgKey(
      {required final AccountId accountId,
      required final ContentId contentId}) = _$AccountImgKeyImpl;

  @override
  AccountId get accountId;
  @override
  ContentId get contentId;
  @override
  @JsonKey(ignore: true)
  _$$AccountImgKeyImplCopyWith<_$AccountImgKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
