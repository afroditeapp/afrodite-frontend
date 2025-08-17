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
  ImageCacheSize get cacheSize => throw _privateConstructorErrorAccountImgKey;

  AccountImgKey copyWith({
    AccountId? accountId,
    ContentId? contentId,
    ImageCacheSize? cacheSize,
  }) => throw _privateConstructorErrorAccountImgKey;
}

/// @nodoc
abstract class _AccountImgKey implements AccountImgKey {
  factory _AccountImgKey({
    required AccountId accountId,
    required ContentId contentId,
    required ImageCacheSize cacheSize,
  }) = _$AccountImgKeyImpl;
}

/// @nodoc
class _$AccountImgKeyImpl with DiagnosticableTreeMixin implements _AccountImgKey {
  _$AccountImgKeyImpl({
    required this.accountId,
    required this.contentId,
    required this.cacheSize,
  });

  @override
  final AccountId accountId;
  @override
  final ContentId contentId;
  @override
  final ImageCacheSize cacheSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountImgKey(accountId: $accountId, contentId: $contentId, cacheSize: $cacheSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountImgKey'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('contentId', contentId))
      ..add(DiagnosticsProperty('cacheSize', cacheSize));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AccountImgKeyImpl &&
        (identical(other.accountId, accountId) ||
          other.accountId == accountId) &&
        (identical(other.contentId, contentId) ||
          other.contentId == contentId) &&
        (identical(other.cacheSize, cacheSize) ||
          other.cacheSize == cacheSize)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    contentId,
    cacheSize,
  );

  @override
  AccountImgKey copyWith({
    Object? accountId,
    Object? contentId,
    Object? cacheSize,
  }) => _$AccountImgKeyImpl(
    accountId: (accountId ?? this.accountId) as AccountId,
    contentId: (contentId ?? this.contentId) as ContentId,
    cacheSize: (cacheSize ?? this.cacheSize) as ImageCacheSize,
  );
}
