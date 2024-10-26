// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_statistics.dart';

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
final _privateConstructorErrorProfileStatisticsData = UnsupportedError(
    'Private constructor ProfileStatisticsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileStatisticsData {
  bool get isLoading => throw _privateConstructorErrorProfileStatisticsData;
  bool get isError => throw _privateConstructorErrorProfileStatisticsData;
  GetProfileStatisticsResult? get item => throw _privateConstructorErrorProfileStatisticsData;

  ProfileStatisticsData copyWith({
    bool? isLoading,
    bool? isError,
    GetProfileStatisticsResult? item,
  }) => throw _privateConstructorErrorProfileStatisticsData;
}

/// @nodoc
abstract class _ProfileStatisticsData implements ProfileStatisticsData {
  factory _ProfileStatisticsData({
    bool isLoading,
    bool isError,
    GetProfileStatisticsResult? item,
  }) = _$ProfileStatisticsDataImpl;
}

/// @nodoc
class _$ProfileStatisticsDataImpl with DiagnosticableTreeMixin implements _ProfileStatisticsData {
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;
  
  _$ProfileStatisticsDataImpl({
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
    return 'ProfileStatisticsData(isLoading: $isLoading, isError: $isError, item: $item)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileStatisticsData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('item', item));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileStatisticsDataImpl &&
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
  ProfileStatisticsData copyWith({
    Object? isLoading,
    Object? isError,
    Object? item = _detectDefaultValueInCopyWith,
  }) => _$ProfileStatisticsDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    item: (item == _detectDefaultValueInCopyWith ? this.item : item) as GetProfileStatisticsResult?,
  );
}
