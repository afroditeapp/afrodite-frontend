// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_statistics_history.dart';

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
final _privateConstructorErrorProfileStatisticsHistoryData = UnsupportedError(
    'Private constructor ProfileStatisticsHistoryData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileStatisticsHistoryData {
  bool get isLoading => throw _privateConstructorErrorProfileStatisticsHistoryData;
  bool get isError => throw _privateConstructorErrorProfileStatisticsHistoryData;
  GetProfileStatisticsHistoryResult? get item => throw _privateConstructorErrorProfileStatisticsHistoryData;

  ProfileStatisticsHistoryData copyWith({
    bool? isLoading,
    bool? isError,
    GetProfileStatisticsHistoryResult? item,
  }) => throw _privateConstructorErrorProfileStatisticsHistoryData;
}

/// @nodoc
abstract class _ProfileStatisticsHistoryData implements ProfileStatisticsHistoryData {
  factory _ProfileStatisticsHistoryData({
    bool isLoading,
    bool isError,
    GetProfileStatisticsHistoryResult? item,
  }) = _$ProfileStatisticsHistoryDataImpl;
}

/// @nodoc
class _$ProfileStatisticsHistoryDataImpl with DiagnosticableTreeMixin implements _ProfileStatisticsHistoryData {
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;
  
  _$ProfileStatisticsHistoryDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.item,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final GetProfileStatisticsHistoryResult? item;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileStatisticsHistoryData(isLoading: $isLoading, isError: $isError, item: $item)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileStatisticsHistoryData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('item', item));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileStatisticsHistoryDataImpl &&
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
  ProfileStatisticsHistoryData copyWith({
    Object? isLoading,
    Object? isError,
    Object? item = _detectDefaultValueInCopyWith,
  }) => _$ProfileStatisticsHistoryDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    item: (item == _detectDefaultValueInCopyWith ? this.item : item) as GetProfileStatisticsHistoryResult?,
  );
}
