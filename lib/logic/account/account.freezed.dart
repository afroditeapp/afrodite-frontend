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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountBlocData {
  AccountId? get accountId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  AccountState? get accountState => throw _privateConstructorUsedError;
  Capabilities get capabilities => throw _privateConstructorUsedError;
  ProfileVisibility get visibility => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountBlocDataCopyWith<AccountBlocData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountBlocDataCopyWith<$Res> {
  factory $AccountBlocDataCopyWith(
          AccountBlocData value, $Res Function(AccountBlocData) then) =
      _$AccountBlocDataCopyWithImpl<$Res, AccountBlocData>;
  @useResult
  $Res call(
      {AccountId? accountId,
      String? email,
      AccountState? accountState,
      Capabilities capabilities,
      ProfileVisibility visibility});
}

/// @nodoc
class _$AccountBlocDataCopyWithImpl<$Res, $Val extends AccountBlocData>
    implements $AccountBlocDataCopyWith<$Res> {
  _$AccountBlocDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
    Object? email = freezed,
    Object? accountState = freezed,
    Object? capabilities = null,
    Object? visibility = null,
  }) {
    return _then(_value.copyWith(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      accountState: freezed == accountState
          ? _value.accountState
          : accountState // ignore: cast_nullable_to_non_nullable
              as AccountState?,
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Capabilities,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as ProfileVisibility,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountBlocDataImplCopyWith<$Res>
    implements $AccountBlocDataCopyWith<$Res> {
  factory _$$AccountBlocDataImplCopyWith(_$AccountBlocDataImpl value,
          $Res Function(_$AccountBlocDataImpl) then) =
      __$$AccountBlocDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AccountId? accountId,
      String? email,
      AccountState? accountState,
      Capabilities capabilities,
      ProfileVisibility visibility});
}

/// @nodoc
class __$$AccountBlocDataImplCopyWithImpl<$Res>
    extends _$AccountBlocDataCopyWithImpl<$Res, _$AccountBlocDataImpl>
    implements _$$AccountBlocDataImplCopyWith<$Res> {
  __$$AccountBlocDataImplCopyWithImpl(
      _$AccountBlocDataImpl _value, $Res Function(_$AccountBlocDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
    Object? email = freezed,
    Object? accountState = freezed,
    Object? capabilities = null,
    Object? visibility = null,
  }) {
    return _then(_$AccountBlocDataImpl(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      accountState: freezed == accountState
          ? _value.accountState
          : accountState // ignore: cast_nullable_to_non_nullable
              as AccountState?,
      capabilities: null == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Capabilities,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as ProfileVisibility,
    ));
  }
}

/// @nodoc

class _$AccountBlocDataImpl
    with DiagnosticableTreeMixin
    implements _AccountBlocData {
  _$AccountBlocDataImpl(
      {this.accountId,
      this.email,
      this.accountState,
      required this.capabilities,
      required this.visibility});

  @override
  final AccountId? accountId;
  @override
  final String? email;
  @override
  final AccountState? accountState;
  @override
  final Capabilities capabilities;
  @override
  final ProfileVisibility visibility;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountBlocData(accountId: $accountId, email: $email, accountState: $accountState, capabilities: $capabilities, visibility: $visibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountBlocData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('accountState', accountState))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('visibility', visibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountBlocDataImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.accountState, accountState) ||
                other.accountState == accountState) &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, accountId, email, accountState, capabilities, visibility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountBlocDataImplCopyWith<_$AccountBlocDataImpl> get copyWith =>
      __$$AccountBlocDataImplCopyWithImpl<_$AccountBlocDataImpl>(
          this, _$identity);
}

abstract class _AccountBlocData implements AccountBlocData {
  factory _AccountBlocData(
      {final AccountId? accountId,
      final String? email,
      final AccountState? accountState,
      required final Capabilities capabilities,
      required final ProfileVisibility visibility}) = _$AccountBlocDataImpl;

  @override
  AccountId? get accountId;
  @override
  String? get email;
  @override
  AccountState? get accountState;
  @override
  Capabilities get capabilities;
  @override
  ProfileVisibility get visibility;
  @override
  @JsonKey(ignore: true)
  _$$AccountBlocDataImplCopyWith<_$AccountBlocDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
