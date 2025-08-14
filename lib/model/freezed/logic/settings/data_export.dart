import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'data_export.freezed.dart';

@freezed
class DataExportData with _$DataExportData {
  DataExportData._();
  factory DataExportData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    DataExportNameAndData? dataExport,
  }) = _DataExportData;
}

class DataExportNameAndData {
  final String name;
  final Uint8List data;
  DataExportNameAndData(this.name, this.data);
}
