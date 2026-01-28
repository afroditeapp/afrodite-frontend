// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_news.dart';

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
final _privateConstructorErrorViewNewsData = UnsupportedError(
    'Private constructor ViewNewsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ViewNewsData {
  bool get isLoading => throw _privateConstructorErrorViewNewsData;
  bool get isError => throw _privateConstructorErrorViewNewsData;
  NewsItem? get item => throw _privateConstructorErrorViewNewsData;

  ViewNewsData copyWith({
    bool? isLoading,
    bool? isError,
    NewsItem? item,
  }) => throw _privateConstructorErrorViewNewsData;
}

/// @nodoc
abstract class _ViewNewsData implements ViewNewsData {
  factory _ViewNewsData({
    bool isLoading,
    bool isError,
    NewsItem? item,
  }) = _$ViewNewsDataImpl;
}

/// @nodoc
class _$ViewNewsDataImpl with DiagnosticableTreeMixin implements _ViewNewsData {
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;

  _$ViewNewsDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.item,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final NewsItem? item;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewNewsData(isLoading: $isLoading, isError: $isError, item: $item)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ViewNewsData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('item', item));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ViewNewsDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.item, item) ||
          other.item == item)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    item,
  );

  @override
  ViewNewsData copyWith({
    Object? isLoading,
    Object? isError,
    Object? item = _detectDefaultValueInCopyWith,
  }) => _$ViewNewsDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    item: (item == _detectDefaultValueInCopyWith ? this.item : item) as NewsItem?,
  );
}
