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
  bool get isLoadingPrimaryContent => throw _privateConstructorErrorContentData;
  bool get primaryImageDataAvailable => throw _privateConstructorErrorContentData;
  MyContent? get securityContent => throw _privateConstructorErrorContentData;
  bool get isLoadingSecurityContent => throw _privateConstructorErrorContentData;

  ContentData copyWith({
    PrimaryProfileContent? primaryContent,
    bool? isLoadingPrimaryContent,
    bool? primaryImageDataAvailable,
    MyContent? securityContent,
    bool? isLoadingSecurityContent,
  }) => throw _privateConstructorErrorContentData;
}

/// @nodoc
abstract class _ContentData extends ContentData {
  factory _ContentData({
    PrimaryProfileContent? primaryContent,
    bool isLoadingPrimaryContent,
    bool primaryImageDataAvailable,
    MyContent? securityContent,
    bool isLoadingSecurityContent,
  }) = _$ContentDataImpl;
  const _ContentData._() : super._();
}

/// @nodoc
class _$ContentDataImpl extends _ContentData {
  static const bool _isLoadingPrimaryContentDefaultValue = true;
  static const bool _primaryImageDataAvailableDefaultValue = false;
  static const bool _isLoadingSecurityContentDefaultValue = true;
  
  _$ContentDataImpl({
    this.primaryContent,
    this.isLoadingPrimaryContent = _isLoadingPrimaryContentDefaultValue,
    this.primaryImageDataAvailable = _primaryImageDataAvailableDefaultValue,
    this.securityContent,
    this.isLoadingSecurityContent = _isLoadingSecurityContentDefaultValue,
  }) : super._();

  @override
  final PrimaryProfileContent? primaryContent;
  @override
  final bool isLoadingPrimaryContent;
  @override
  final bool primaryImageDataAvailable;
  @override
  final MyContent? securityContent;
  @override
  final bool isLoadingSecurityContent;

  @override
  String toString() {
    return 'ContentData(primaryContent: $primaryContent, isLoadingPrimaryContent: $isLoadingPrimaryContent, primaryImageDataAvailable: $primaryImageDataAvailable, securityContent: $securityContent, isLoadingSecurityContent: $isLoadingSecurityContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ContentDataImpl &&
        (identical(other.primaryContent, primaryContent) ||
          other.primaryContent == primaryContent) &&
        (identical(other.isLoadingPrimaryContent, isLoadingPrimaryContent) ||
          other.isLoadingPrimaryContent == isLoadingPrimaryContent) &&
        (identical(other.primaryImageDataAvailable, primaryImageDataAvailable) ||
          other.primaryImageDataAvailable == primaryImageDataAvailable) &&
        (identical(other.securityContent, securityContent) ||
          other.securityContent == securityContent) &&
        (identical(other.isLoadingSecurityContent, isLoadingSecurityContent) ||
          other.isLoadingSecurityContent == isLoadingSecurityContent)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    primaryContent,
    isLoadingPrimaryContent,
    primaryImageDataAvailable,
    securityContent,
    isLoadingSecurityContent,
  );

  @override
  ContentData copyWith({
    Object? primaryContent = _detectDefaultValueInCopyWith,
    Object? isLoadingPrimaryContent,
    Object? primaryImageDataAvailable,
    Object? securityContent = _detectDefaultValueInCopyWith,
    Object? isLoadingSecurityContent,
  }) => _$ContentDataImpl(
    primaryContent: (primaryContent == _detectDefaultValueInCopyWith ? this.primaryContent : primaryContent) as PrimaryProfileContent?,
    isLoadingPrimaryContent: (isLoadingPrimaryContent ?? this.isLoadingPrimaryContent) as bool,
    primaryImageDataAvailable: (primaryImageDataAvailable ?? this.primaryImageDataAvailable) as bool,
    securityContent: (securityContent == _detectDefaultValueInCopyWith ? this.securityContent : securityContent) as MyContent?,
    isLoadingSecurityContent: (isLoadingSecurityContent ?? this.isLoadingSecurityContent) as bool,
  );
}
