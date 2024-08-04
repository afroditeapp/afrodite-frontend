

import 'dart:isolate';

import 'package:database/database.dart';
import 'package:native_utils/message.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

// TODO(architechture): Consider collecting all singletons which contains
//                      account specific data to one singleton which can
//                      recreate the singletons when account is changed.
//                      That style would avoid the AccountId checking
//                      in MessageKeyGenerator.
//                      Or prehaps account specific database and API access
//                      needs accessor objects which guarantee access to
//                      only specific database and API when login is valid.

enum KeyGeneratorState {
  idle,
  inProgress,
}

class MessageKeyManager {
  BehaviorSubject<KeyGeneratorState> generation =
    BehaviorSubject.seeded(KeyGeneratorState.idle, sync: true);

  DatabaseManager db = DatabaseManager.getInstance();
  LoginRepository login = LoginRepository.getInstance();
  ApiManager api = ApiManager.getInstance();

  /// Returns null if there is some error
  Future<AllKeyData?> generateOrLoadMessageKeys(AccountId accountId) async {
    if (generation.value == KeyGeneratorState.inProgress) {
      await generation.where((v) => v == KeyGeneratorState.idle).first;
      if (accountId != await login.accountId.first) {
        return null;
      }
      return await _loadMessageKeys(accountId);
    } else {
      generation.add(KeyGeneratorState.inProgress);
      if (accountId != await login.accountId.first) {
        return null;
      }
      var result = await _loadMessageKeys(accountId);
      result ??= await _generateMessageKeys(accountId);
      generation.add(KeyGeneratorState.idle);
      return result;
    }
  }

  Future<AllKeyData?> _loadMessageKeys(AccountId accountId) async {
    final keys = await db.accountData((db) => db.daoMessageKeys.getMessageKeys()).ok();
    return keys;
  }

  Future<AllKeyData?> _generateMessageKeys(AccountId accountId) async {
    final newKeys = await Isolate.run(() => generateMessageKeys(accountId.accountId));
    if (accountId != await login.accountId.first) {
      return null;
    }
    // TODO: Set the key to server and save all keys to DB

    return null;
  }
}
