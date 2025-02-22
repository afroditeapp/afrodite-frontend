//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReportTypeNumber {
  /// Instantiate a new enum with the provided [value].
  const ReportTypeNumber._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const profileName = ReportTypeNumber._(r'ProfileName');
  static const profileText = ReportTypeNumber._(r'ProfileText');
  static const profileContent = ReportTypeNumber._(r'ProfileContent');
  static const chatMessage = ReportTypeNumber._(r'ChatMessage');

  /// List of all possible values in this [enum][ReportTypeNumber].
  static const values = <ReportTypeNumber>[
    profileName,
    profileText,
    profileContent,
    chatMessage,
  ];

  static ReportTypeNumber? fromJson(dynamic value) => ReportTypeNumberTypeTransformer().decode(value);

  static List<ReportTypeNumber> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportTypeNumber>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportTypeNumber.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReportTypeNumber] to String,
/// and [decode] dynamic data back to [ReportTypeNumber].
class ReportTypeNumberTypeTransformer {
  factory ReportTypeNumberTypeTransformer() => _instance ??= const ReportTypeNumberTypeTransformer._();

  const ReportTypeNumberTypeTransformer._();

  String encode(ReportTypeNumber data) => data.value;

  /// Decodes a [dynamic value][data] to a ReportTypeNumber.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReportTypeNumber? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ProfileName': return ReportTypeNumber.profileName;
        case r'ProfileText': return ReportTypeNumber.profileText;
        case r'ProfileContent': return ReportTypeNumber.profileContent;
        case r'ChatMessage': return ReportTypeNumber.chatMessage;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReportTypeNumberTypeTransformer] instance.
  static ReportTypeNumberTypeTransformer? _instance;
}

