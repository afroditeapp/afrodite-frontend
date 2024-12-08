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
  PrimaryProfileContent? get primaryContent => throw _privateConstructorErrorContentData;
  bool get primaryImageDataAvailable => throw _privateConstructorErrorContentData;
  MyContent? get securityContent => throw _privateConstructorErrorContentData;

  ContentData copyWith({
    PrimaryProfileContent? primaryContent,
    bool? primaryImageDataAvailable,
    MyContent? securityContent,
  }) => throw _privateConstructorErrorContentData;
}

/// @nodoc
abstract class _ContentData extends ContentData {
  factory _ContentData({
    PrimaryProfileContent? primaryContent,
    bool primaryImageDataAvailable,
    MyContent? securityContent,
  }) = _$ContentDataImpl;
  const _ContentData._() : super._();
}

/// @nodoc
class _$ContentDataImpl extends _ContentData {
  static const bool _primaryImageDataAvailableDefaultValue = false;
  
  _$ContentDataImpl({
    this.primaryContent,
    this.primaryImageDataAvailable = _primaryImageDataAvailableDefaultValue,
    this.securityContent,
  }) : super._();

  @override
  final PrimaryProfileContent? primaryContent;
  @override
  final bool primaryImageDataAvailable;
  @override
  final MyContent? securityContent;

  @override
  String toString() {
    return 'ContentData(primaryContent: $primaryContent, primaryImageDataAvailable: $primaryImageDataAvailable, securityContent: $securityContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ContentDataImpl &&
        (identical(other.primaryContent, primaryContent) ||
          other.primaryContent == primaryContent) &&
        (identical(other.primaryImageDataAvailable, primaryImageDataAvailable) ||
          other.primaryImageDataAvailable == primaryImageDataAvailable) &&
        (identical(other.securityContent, securityContent) ||
          other.securityContent == securityContent)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    primaryContent,
    primaryImageDataAvailable,
    securityContent,
  );

  @override
  ContentData copyWith({
    Object? primaryContent = _detectDefaultValueInCopyWith,
    Object? primaryImageDataAvailable,
    Object? securityContent = _detectDefaultValueInCopyWith,
  }) => _$ContentDataImpl(
    primaryContent: (primaryContent == _detectDefaultValueInCopyWith ? this.primaryContent : primaryContent) as PrimaryProfileContent?,
    primaryImageDataAvailable: (primaryImageDataAvailable ?? this.primaryImageDataAvailable) as bool,
    securityContent: (securityContent == _detectDefaultValueInCopyWith ? this.securityContent : securityContent) as MyContent?,
  );
}
