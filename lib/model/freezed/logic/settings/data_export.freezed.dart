// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_export.dart';

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
final _privateConstructorErrorDataExportData = UnsupportedError(
    'Private constructor DataExportData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$DataExportData {
  bool get isLoading => throw _privateConstructorErrorDataExportData;
  bool get isError => throw _privateConstructorErrorDataExportData;
  DataExportNameAndData? get dataExport => throw _privateConstructorErrorDataExportData;

  DataExportData copyWith({
    bool? isLoading,
    bool? isError,
    DataExportNameAndData? dataExport,
  }) => throw _privateConstructorErrorDataExportData;
}

/// @nodoc
abstract class _DataExportData extends DataExportData {
  factory _DataExportData({
    bool isLoading,
    bool isError,
    DataExportNameAndData? dataExport,
  }) = _$DataExportDataImpl;
  _DataExportData._() : super._();
}

/// @nodoc
class _$DataExportDataImpl extends _DataExportData with DiagnosticableTreeMixin {
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  
  _$DataExportDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.dataExport,
  }) : super._();

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final DataExportNameAndData? dataExport;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataExportData(isLoading: $isLoading, isError: $isError, dataExport: $dataExport)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataExportData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('dataExport', dataExport));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$DataExportDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.dataExport, dataExport) ||
          other.dataExport == dataExport)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    dataExport,
  );

  @override
  DataExportData copyWith({
    Object? isLoading,
    Object? isError,
    Object? dataExport = _detectDefaultValueInCopyWith,
  }) => _$DataExportDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    dataExport: (dataExport == _detectDefaultValueInCopyWith ? this.dataExport : dataExport) as DataExportNameAndData?,
  );
}
