// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_img_key.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorAccountImgKey = UnsupportedError(
    'Private constructor AccountImgKey._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$AccountImgKey {
  AccountId get accountId => throw _privateConstructorErrorAccountImgKey;
  ContentId get contentId => throw _privateConstructorErrorAccountImgKey;

  AccountImgKey copyWith({
    AccountId? accountId,
    ContentId? contentId,
  }) => throw _privateConstructorErrorAccountImgKey;
}

/// @nodoc
abstract class _AccountImgKey implements AccountImgKey {
  factory _AccountImgKey({
    required AccountId accountId,
    required ContentId contentId,
  }) = _$AccountImgKeyImpl;
}

/// @nodoc
class _$AccountImgKeyImpl with DiagnosticableTreeMixin implements _AccountImgKey {
  _$AccountImgKeyImpl({
    required this.accountId,
    required this.contentId,
  });

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
          other.contentId == contentId)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    contentId,
  );

  @override
  AccountImgKey copyWith({
    Object? accountId,
    Object? contentId,
  }) => _$AccountImgKeyImpl(
    accountId: (accountId ?? this.accountId) as AccountId,
    contentId: (contentId ?? this.contentId) as ContentId,
  );
}
