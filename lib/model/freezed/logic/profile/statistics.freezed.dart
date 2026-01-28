// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

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
final _privateConstructorErrorStatisticsData = UnsupportedError(
    'Private constructor StatisticsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$StatisticsData {
  bool get isLoading => throw _privateConstructorErrorStatisticsData;
  bool get isError => throw _privateConstructorErrorStatisticsData;
  GetProfileStatisticsResult? get item => throw _privateConstructorErrorStatisticsData;

  StatisticsData copyWith({
    bool? isLoading,
    bool? isError,
    GetProfileStatisticsResult? item,
  }) => throw _privateConstructorErrorStatisticsData;
}

/// @nodoc
abstract class _StatisticsData implements StatisticsData {
  factory _StatisticsData({
    bool isLoading,
    bool isError,
    GetProfileStatisticsResult? item,
  }) = _$StatisticsDataImpl;
}

/// @nodoc
class _$StatisticsDataImpl with DiagnosticableTreeMixin implements _StatisticsData {
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;

  _$StatisticsDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.item,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final GetProfileStatisticsResult? item;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatisticsData(isLoading: $isLoading, isError: $isError, item: $item)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatisticsData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('item', item));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$StatisticsDataImpl &&
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
  StatisticsData copyWith({
    Object? isLoading,
    Object? isError,
    Object? item = _detectDefaultValueInCopyWith,
  }) => _$StatisticsDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    item: (item == _detectDefaultValueInCopyWith ? this.item : item) as GetProfileStatisticsResult?,
  );
}
