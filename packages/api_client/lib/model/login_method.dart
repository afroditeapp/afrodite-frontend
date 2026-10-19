//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum LoginMethod {
  email._(r'Email'),
  apple._(r'Apple'),
  google._(r'Google'),
  demo._(r'Demo'),
  bot._(r'Bot'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const LoginMethod._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [LoginMethod] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static LoginMethod? fromJson(dynamic value) => LoginMethodTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [LoginMethod]
  /// that were successfully decoded from the passed [JSON][json].
  static List<LoginMethod> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginMethod>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginMethod.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LoginMethod] to String,
/// and [decode] dynamic data back to [LoginMethod].
class LoginMethodTypeTransformer {
  factory LoginMethodTypeTransformer() => _instance ??= const LoginMethodTypeTransformer._();

  const LoginMethodTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(LoginMethod data) => data._value;

  /// Returns the instance of [LoginMethod] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LoginMethod? decode(dynamic data, {bool allowNull = true}) {
    if (data is LoginMethod) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Email': return LoginMethod.email;
        case r'Apple': return LoginMethod.apple;
        case r'Google': return LoginMethod.google;
        case r'Demo': return LoginMethod.demo;
        case r'Bot': return LoginMethod.bot;
        case r'unknown_default_open_api': return LoginMethod.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static LoginMethodTypeTransformer? _instance;
}

