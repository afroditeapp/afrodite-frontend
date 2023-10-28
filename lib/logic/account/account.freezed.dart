// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountData {
  AccountId? get accountId => throw _privateConstructorUsedError;
  AccessToken? get accessToken => throw _privateConstructorUsedError;
  Capabilities get capabilities => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountDataCopyWith<AccountBlocData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDataCopyWith<$Res> {
  factory $AccountDataCopyWith(
          AccountBlocData value, $Res Function(AccountBlocData) then) =
      _$AccountDataCopyWithImpl<$Res, AccountBlocData>;
  @useResult
  $Res call(
      {AccountId? accountId,
      AccessToken? accessToken,
      Capabilities capabilities});
}

/// @nodoc
class _$AccountDataCopyWithImpl<$Res, $Val extends AccountBlocData>
    implements $AccountDataCopyWith<$Res> {
  _$AccountDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
    Object? accessToken = freezed,
    Object? capabilities = null,
  }) {
    return _then(_value.copyWith(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as AccessToken?,
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Capabilities,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountDataImplCopyWith<$Res>
    implements $AccountDataCopyWith<$Res> {
  factory _$$AccountDataImplCopyWith(
          _$AccountDataImpl value, $Res Function(_$AccountDataImpl) then) =
      __$$AccountDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AccountId? accountId,
      AccessToken? accessToken,
      Capabilities capabilities});
}

/// @nodoc
class __$$AccountDataImplCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res, _$AccountDataImpl>
    implements _$$AccountDataImplCopyWith<$Res> {
  __$$AccountDataImplCopyWithImpl(
      _$AccountDataImpl _value, $Res Function(_$AccountDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
    Object? accessToken = freezed,
    Object? capabilities = null,
  }) {
    return _then(_$AccountDataImpl(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as AccessToken?,
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Capabilities,
    ));
  }
}

/// @nodoc

class _$AccountDataImpl with DiagnosticableTreeMixin implements _AccountData {
  _$AccountDataImpl(
      {this.accountId, this.accessToken, required this.capabilities});

  @override
  final AccountId? accountId;
  @override
  final AccessToken? accessToken;
  @override
  final Capabilities capabilities;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountData(accountId: $accountId, accessToken: $accessToken, capabilities: $capabilities)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('capabilities', capabilities));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountDataImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, accountId, accessToken, capabilities);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountDataImplCopyWith<_$AccountDataImpl> get copyWith =>
      __$$AccountDataImplCopyWithImpl<_$AccountDataImpl>(this, _$identity);
}

abstract class _AccountData implements AccountBlocData {
  factory _AccountData(
      {final AccountId? accountId,
      final AccessToken? accessToken,
      required final Capabilities capabilities}) = _$AccountDataImpl;

  @override
  AccountId? get accountId;
  @override
  AccessToken? get accessToken;
  @override
  Capabilities get capabilities;
  @override
  @JsonKey(ignore: true)
  _$$AccountDataImplCopyWith<_$AccountDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
