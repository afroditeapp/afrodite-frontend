/// Key value storage


import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum KvString {
  accountId,
  accountCapabilities,
  /// AccountState json
  accountState,
  /// Base64 string
  accountRefreshToken,
  accountAccessToken,
  /// Base64 string
  mediaRefreshToken,
  mediaAccessToken,
  /// Base64 string
  profileRefreshToken,
  profileAccessToken;

  String key() {
    return "kv-string-key-$name";
  }

  // String defaultValue() {
  //   switch (this) {
  //     case _: return "";
  //   }
  // }
}

class KvStorageManager {
  static final _instance = KvStorageManager._private();
  KvStorageManager._private();
  factory KvStorageManager.getInstance() {
    return _instance;
  }

  final PublishSubject<(KvString, String)> _updates =
    PublishSubject();

  Stream<(KvString, String)> get updates => _updates;

  Future<String?> getString(KvString key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key.key());
  }

  /// Set new string. If it is same than the previous, then nothing is done.
  Future<void> setString(KvString key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final current = await preferences.getString(key.key());
    if (current == value) {
      return;
    }
    await preferences.setString(key.key(), value);
    _updates.add((key, value));
  }

  Future<T?> getStringAnd<T>(KvString key, T? Function(String) convert) async {
    final value = await getString(key);
    if (value != null) {
      return convert(value);
    } else {
      return null;
    }
  }

  Stream<String> _getUpdatesForRaw(KvString key) {
    return updates.where((event) => event.$1 == key).map((event) => event.$2);
  }

  ValueStream<String?> getUpdatesFor(KvString key) {
    return Stream.fromFuture(getString(key))
      .concatWith([_getUpdatesForRaw(key)])
      .shareValue();
  }

  ValueStream<T?> getUpdatesForWithConversion<T extends Object>(KvString key, T Function(String) convert) {
    return Stream.fromFuture(getString(key))
      .concatWith([_getUpdatesForRaw(key)])
      .map((event) {
        if (event != null) {
          return convert(event);
        } else {
          return null;
        }
      })
      .shareValue();
  }

  ValueStream<T> getUpdatesForWithConversionAndDefaultIfNull<T extends Object>(KvString key, T Function(String) convert, T defaultValue) {
    return Stream.fromFuture(getString(key))
      .concatWith([_getUpdatesForRaw(key)])
      .map((event) {
        if (event != null) {
          return convert(event);
        } else {
          return null;
        }
      })
      .map((event) {
        if (event == null) {
          return defaultValue;
        } else {
          return event;
        }
      })
      .shareValue();
  }

  // ValueStream<T> getUpdatesForWithConversionErrorAndAllNullToDefault<T extends Object>(KvString key, T? Function(String) convert, T defaultValue) {
  //   return Stream.fromFuture(getString(key))
  //     .concatWith([_getUpdatesForRaw(key)])
  //     .map((event) {
  //       if (event != null) {
  //         return convert(event);
  //       } else {
  //         return null;
  //       }
  //     })
  //     .map((event) {
  //       if (event == null) {
  //         return defaultValue;
  //       } else {
  //         return event;
  //       }
  //     })
  //     .shareValue();
  // }
}
