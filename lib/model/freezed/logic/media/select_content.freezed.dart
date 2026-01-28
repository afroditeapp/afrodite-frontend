// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_content.dart';

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
final _privateConstructorErrorSelectContentData = UnsupportedError(
    'Private constructor SelectContentData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SelectContentData {
  UnmodifiableList<ContentInfoDetailed> get availableContent => throw _privateConstructorErrorSelectContentData;
  AccountContent? get accountContent => throw _privateConstructorErrorSelectContentData;
  int get maxContent => throw _privateConstructorErrorSelectContentData;
  bool get showAddNewContent => throw _privateConstructorErrorSelectContentData;
  bool get isLoading => throw _privateConstructorErrorSelectContentData;
  bool get isError => throw _privateConstructorErrorSelectContentData;

  SelectContentData copyWith({
    UnmodifiableList<ContentInfoDetailed>? availableContent,
    AccountContent? accountContent,
    int? maxContent,
    bool? showAddNewContent,
    bool? isLoading,
    bool? isError,
  }) => throw _privateConstructorErrorSelectContentData;
}

/// @nodoc
abstract class _SelectContentData implements SelectContentData {
  factory _SelectContentData({
    UnmodifiableList<ContentInfoDetailed> availableContent,
    AccountContent? accountContent,
    int maxContent,
    bool showAddNewContent,
    bool isLoading,
    bool isError,
  }) = _$SelectContentDataImpl;
}

/// @nodoc
class _$SelectContentDataImpl implements _SelectContentData {
  static const UnmodifiableList<ContentInfoDetailed> _availableContentDefaultValue = UnmodifiableList<ContentInfoDetailed>.empty();
  static const int _maxContentDefaultValue = 0;
  static const bool _showAddNewContentDefaultValue = false;
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;

  _$SelectContentDataImpl({
    this.availableContent = _availableContentDefaultValue,
    this.accountContent,
    this.maxContent = _maxContentDefaultValue,
    this.showAddNewContent = _showAddNewContentDefaultValue,
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
  });

  @override
  final UnmodifiableList<ContentInfoDetailed> availableContent;
  @override
  final AccountContent? accountContent;
  @override
  final int maxContent;
  @override
  final bool showAddNewContent;
  @override
  final bool isLoading;
  @override
  final bool isError;

  @override
  String toString() {
    return 'SelectContentData(availableContent: $availableContent, accountContent: $accountContent, maxContent: $maxContent, showAddNewContent: $showAddNewContent, isLoading: $isLoading, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SelectContentDataImpl &&
        (identical(other.availableContent, availableContent) ||
          other.availableContent == availableContent) &&
        (identical(other.accountContent, accountContent) ||
          other.accountContent == accountContent) &&
        (identical(other.maxContent, maxContent) ||
          other.maxContent == maxContent) &&
        (identical(other.showAddNewContent, showAddNewContent) ||
          other.showAddNewContent == showAddNewContent) &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    availableContent,
    accountContent,
    maxContent,
    showAddNewContent,
    isLoading,
    isError,
  );

  @override
  SelectContentData copyWith({
    Object? availableContent,
    Object? accountContent = _detectDefaultValueInCopyWith,
    Object? maxContent,
    Object? showAddNewContent,
    Object? isLoading,
    Object? isError,
  }) => _$SelectContentDataImpl(
    availableContent: (availableContent ?? this.availableContent) as UnmodifiableList<ContentInfoDetailed>,
    accountContent: (accountContent == _detectDefaultValueInCopyWith ? this.accountContent : accountContent) as AccountContent?,
    maxContent: (maxContent ?? this.maxContent) as int,
    showAddNewContent: (showAddNewContent ?? this.showAddNewContent) as bool,
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
  );
}
