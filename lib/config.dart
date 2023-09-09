

import 'dart:io';

import 'package:pihka_frontend/storage/kv.dart';

const String _defaultAccountServerAddressAndroid = "https://localdev.***REMOVED***:3000"; // Should point to 10.0.2.2 (Android emulator host)
const String _defaultAccountServerAddressIos = "https://192.168.0.1:3000";

String defaultAccountServerAddress() {
  if (Platform.isAndroid) {
    return _defaultAccountServerAddressAndroid;
  } else if (Platform.isIOS) {
    return _defaultAccountServerAddressIos;
  } else {
    throw UnimplementedError();
  }
}

const String _defaultMediaServerAddress = "https://10.0.2.2:3000";
const String _defaultProfileServerAddress = "https://10.0.2.2:3000";

String defaultMediaServerAddress() {
  return _defaultMediaServerAddress;
}

String defaultProfileServerAddress() {
  return _defaultProfileServerAddress;
}

enum KvStringWithDefault implements KvStringProvider {
  accountServerAddress(
    KvString.accountServerAddress,
    defaultAccountServerAddress,
  ),
  mediaServerAddress(
    KvString.mediaServerAddress,
    defaultMediaServerAddress,
  ),
  profileServerAddress(
    KvString.profileServerAddress,
    defaultProfileServerAddress,
  );

  const KvStringWithDefault(
    this.key,
    this.defaultValueGetter,
  );

  final KvString key;
  final String Function() defaultValueGetter;

  String defaultValue() {
    return defaultValueGetter();
  }

  @override
  KvString getKvString() {
    return key;
  }
}
