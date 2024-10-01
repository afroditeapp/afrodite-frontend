// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorContentData = UnsupportedError(
    'Private constructor ContentData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ContentData {
  CurrentProfileContent? get content => throw _privateConstructorErrorContentData;
  ContentId? get securityContent => throw _privateConstructorErrorContentData;
  PendingProfileContentInternal? get pendingContent => throw _privateConstructorErrorContentData;
  ContentId? get pendingSecurityContent => throw _privateConstructorErrorContentData;
  bool get primaryImageDataAvailable => throw _privateConstructorErrorContentData;

  ContentData copyWith({
    CurrentProfileContent? content,
    ContentId? securityContent,
    PendingProfileContentInternal? pendingContent,
    ContentId? pendingSecurityContent,
    bool? primaryImageDataAvailable,
  }) => throw _privateConstructorErrorContentData;
}

/// @nodoc
abstract class _ContentData extends ContentData {
  factory _ContentData({
    CurrentProfileContent? content,
    ContentId? securityContent,
    PendingProfileContentInternal? pendingContent,
    ContentId? pendingSecurityContent,
    bool primaryImageDataAvailable,
  }) = _$ContentDataImpl;
  const _ContentData._() : super._();
}

/// @nodoc
class _$ContentDataImpl extends _ContentData {
  static const bool _primaryImageDataAvailableDefaultValue = false;
  
  _$ContentDataImpl({
    this.content,
    this.securityContent,
    this.pendingContent,
    this.pendingSecurityContent,
    this.primaryImageDataAvailable = _primaryImageDataAvailableDefaultValue,
  }) : super._();

  @override
  final CurrentProfileContent? content;
  @override
  final ContentId? securityContent;
  @override
  final PendingProfileContentInternal? pendingContent;
  @override
  final ContentId? pendingSecurityContent;
  @override
  final bool primaryImageDataAvailable;

  @override
  String toString() {
    return 'ContentData(content: $content, securityContent: $securityContent, pendingContent: $pendingContent, pendingSecurityContent: $pendingSecurityContent, primaryImageDataAvailable: $primaryImageDataAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ContentDataImpl &&
        (identical(other.content, content) ||
          other.content == content) &&
        (identical(other.securityContent, securityContent) ||
          other.securityContent == securityContent) &&
        (identical(other.pendingContent, pendingContent) ||
          other.pendingContent == pendingContent) &&
        (identical(other.pendingSecurityContent, pendingSecurityContent) ||
          other.pendingSecurityContent == pendingSecurityContent) &&
        (identical(other.primaryImageDataAvailable, primaryImageDataAvailable) ||
          other.primaryImageDataAvailable == primaryImageDataAvailable)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    content,
    securityContent,
    pendingContent,
    pendingSecurityContent,
    primaryImageDataAvailable,
  );

  @override
  ContentData copyWith({
    Object? content = _detectDefaultValueInCopyWith,
    Object? securityContent = _detectDefaultValueInCopyWith,
    Object? pendingContent = _detectDefaultValueInCopyWith,
    Object? pendingSecurityContent = _detectDefaultValueInCopyWith,
    Object? primaryImageDataAvailable,
  }) => _$ContentDataImpl(
    content: (content == _detectDefaultValueInCopyWith ? this.content : content) as CurrentProfileContent?,
    securityContent: (securityContent == _detectDefaultValueInCopyWith ? this.securityContent : securityContent) as ContentId?,
    pendingContent: (pendingContent == _detectDefaultValueInCopyWith ? this.pendingContent : pendingContent) as PendingProfileContentInternal?,
    pendingSecurityContent: (pendingSecurityContent == _detectDefaultValueInCopyWith ? this.pendingSecurityContent : pendingSecurityContent) as ContentId?,
    primaryImageDataAvailable: (primaryImageDataAvailable ?? this.primaryImageDataAvailable) as bool,
  );
}
