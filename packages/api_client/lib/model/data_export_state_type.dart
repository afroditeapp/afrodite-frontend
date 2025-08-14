//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DataExportStateType {
  /// Instantiate a new enum with the provided [value].
  const DataExportStateType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const empty = DataExportStateType._(r'Empty');
  static const inProgress = DataExportStateType._(r'InProgress');
  static const done = DataExportStateType._(r'Done');
  static const error = DataExportStateType._(r'Error');

  /// List of all possible values in this [enum][DataExportStateType].
  static const values = <DataExportStateType>[
    empty,
    inProgress,
    done,
    error,
  ];

  static DataExportStateType? fromJson(dynamic value) => DataExportStateTypeTypeTransformer().decode(value);

  static List<DataExportStateType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DataExportStateType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DataExportStateType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DataExportStateType] to String,
/// and [decode] dynamic data back to [DataExportStateType].
class DataExportStateTypeTypeTransformer {
  factory DataExportStateTypeTypeTransformer() => _instance ??= const DataExportStateTypeTypeTransformer._();

  const DataExportStateTypeTypeTransformer._();

  String encode(DataExportStateType data) => data.value;

  /// Decodes a [dynamic value][data] to a DataExportStateType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DataExportStateType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Empty': return DataExportStateType.empty;
        case r'InProgress': return DataExportStateType.inProgress;
        case r'Done': return DataExportStateType.done;
        case r'Error': return DataExportStateType.error;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [DataExportStateTypeTypeTransformer] instance.
  static DataExportStateTypeTypeTransformer? _instance;
}

