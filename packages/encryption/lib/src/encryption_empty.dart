

import 'package:encryption_common/encryption_common.dart';
import 'package:utils/utils.dart';

class SecureStorageManager extends AppSingleton {
  static final _instance = SecureStorageManager._private();
  SecureStorageManager._private();
  factory SecureStorageManager.getInstance() {
    return _instance;
  }

  @override
  Future<void> init() async {

  }

  Future<String> getDbEncryptionKeyOrCreateNewKeyAndRecreateDatabasesDir(
    {
      required bool backgroundDb,
      required DatabaseRemover remover,
    }
  ) async {
    throw UnsupportedError("Unsupported platform");
  }
}
