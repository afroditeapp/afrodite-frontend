// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConversationData {
  AccountId get accountId => throw _privateConstructorUsedError;
  String get profileName => throw _privateConstructorUsedError;
  File get primaryProfileImage => throw _privateConstructorUsedError;
  bool get isMatch => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;

  /// Resets chat box to empty state
  bool get isSendSuccessful => throw _privateConstructorUsedError;
  int get messageCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConversationDataCopyWith<ConversationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationDataCopyWith<$Res> {
  factory $ConversationDataCopyWith(
          ConversationData value, $Res Function(ConversationData) then) =
      _$ConversationDataCopyWithImpl<$Res, ConversationData>;
  @useResult
  $Res call(
      {AccountId accountId,
      String profileName,
      File primaryProfileImage,
      bool isMatch,
      bool isBlocked,
      bool isSendSuccessful,
      int messageCount});
}

/// @nodoc
class _$ConversationDataCopyWithImpl<$Res, $Val extends ConversationData>
    implements $ConversationDataCopyWith<$Res> {
  _$ConversationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? profileName = null,
    Object? primaryProfileImage = null,
    Object? isMatch = null,
    Object? isBlocked = null,
    Object? isSendSuccessful = null,
    Object? messageCount = null,
  }) {
    return _then(_value.copyWith(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId,
      profileName: null == profileName
          ? _value.profileName
          : profileName // ignore: cast_nullable_to_non_nullable
              as String,
      primaryProfileImage: null == primaryProfileImage
          ? _value.primaryProfileImage
          : primaryProfileImage // ignore: cast_nullable_to_non_nullable
              as File,
      isMatch: null == isMatch
          ? _value.isMatch
          : isMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      isSendSuccessful: null == isSendSuccessful
          ? _value.isSendSuccessful
          : isSendSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationDataImplCopyWith<$Res>
    implements $ConversationDataCopyWith<$Res> {
  factory _$$ConversationDataImplCopyWith(_$ConversationDataImpl value,
          $Res Function(_$ConversationDataImpl) then) =
      __$$ConversationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AccountId accountId,
      String profileName,
      File primaryProfileImage,
      bool isMatch,
      bool isBlocked,
      bool isSendSuccessful,
      int messageCount});
}

/// @nodoc
class __$$ConversationDataImplCopyWithImpl<$Res>
    extends _$ConversationDataCopyWithImpl<$Res, _$ConversationDataImpl>
    implements _$$ConversationDataImplCopyWith<$Res> {
  __$$ConversationDataImplCopyWithImpl(_$ConversationDataImpl _value,
      $Res Function(_$ConversationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? profileName = null,
    Object? primaryProfileImage = null,
    Object? isMatch = null,
    Object? isBlocked = null,
    Object? isSendSuccessful = null,
    Object? messageCount = null,
  }) {
    return _then(_$ConversationDataImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountId,
      profileName: null == profileName
          ? _value.profileName
          : profileName // ignore: cast_nullable_to_non_nullable
              as String,
      primaryProfileImage: null == primaryProfileImage
          ? _value.primaryProfileImage
          : primaryProfileImage // ignore: cast_nullable_to_non_nullable
              as File,
      isMatch: null == isMatch
          ? _value.isMatch
          : isMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      isSendSuccessful: null == isSendSuccessful
          ? _value.isSendSuccessful
          : isSendSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ConversationDataImpl
    with DiagnosticableTreeMixin
    implements _ConversationData {
  _$ConversationDataImpl(
      {required this.accountId,
      required this.profileName,
      required this.primaryProfileImage,
      this.isMatch = false,
      this.isBlocked = false,
      this.isSendSuccessful = false,
      this.messageCount = 0});

  @override
  final AccountId accountId;
  @override
  final String profileName;
  @override
  final File primaryProfileImage;
  @override
  @JsonKey()
  final bool isMatch;
  @override
  @JsonKey()
  final bool isBlocked;

  /// Resets chat box to empty state
  @override
  @JsonKey()
  final bool isSendSuccessful;
  @override
  @JsonKey()
  final int messageCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationData(accountId: $accountId, profileName: $profileName, primaryProfileImage: $primaryProfileImage, isMatch: $isMatch, isBlocked: $isBlocked, isSendSuccessful: $isSendSuccessful, messageCount: $messageCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConversationData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('profileName', profileName))
      ..add(DiagnosticsProperty('primaryProfileImage', primaryProfileImage))
      ..add(DiagnosticsProperty('isMatch', isMatch))
      ..add(DiagnosticsProperty('isBlocked', isBlocked))
      ..add(DiagnosticsProperty('isSendSuccessful', isSendSuccessful))
      ..add(DiagnosticsProperty('messageCount', messageCount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationDataImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.profileName, profileName) ||
                other.profileName == profileName) &&
            (identical(other.primaryProfileImage, primaryProfileImage) ||
                other.primaryProfileImage == primaryProfileImage) &&
            (identical(other.isMatch, isMatch) || other.isMatch == isMatch) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.isSendSuccessful, isSendSuccessful) ||
                other.isSendSuccessful == isSendSuccessful) &&
            (identical(other.messageCount, messageCount) ||
                other.messageCount == messageCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId, profileName,
      primaryProfileImage, isMatch, isBlocked, isSendSuccessful, messageCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationDataImplCopyWith<_$ConversationDataImpl> get copyWith =>
      __$$ConversationDataImplCopyWithImpl<_$ConversationDataImpl>(
          this, _$identity);
}

abstract class _ConversationData implements ConversationData {
  factory _ConversationData(
      {required final AccountId accountId,
      required final String profileName,
      required final File primaryProfileImage,
      final bool isMatch,
      final bool isBlocked,
      final bool isSendSuccessful,
      final int messageCount}) = _$ConversationDataImpl;

  @override
  AccountId get accountId;
  @override
  String get profileName;
  @override
  File get primaryProfileImage;
  @override
  bool get isMatch;
  @override
  bool get isBlocked;
  @override

  /// Resets chat box to empty state
  bool get isSendSuccessful;
  @override
  int get messageCount;
  @override
  @JsonKey(ignore: true)
  _$$ConversationDataImplCopyWith<_$ConversationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
