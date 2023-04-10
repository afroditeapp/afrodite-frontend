


import 'dart:async';

import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


const KEY_ACCOUNT_ID = "account-id";
const KEY_API_KEY = "api-key";

class AccountRepository {
  final ApiProvider api;
  final StreamController<void> accountIdUpdated = StreamController();
  final StreamController<void> apiKeyUpdated = StreamController();

  AccountRepository(this.api);

  Stream<MainState> accountState() async* {
    yield MainState.splashScreen;

    await Future.delayed(const Duration(seconds: 2), () {});


    String accountId;
    getAccountId:
    while (true) {
      await for (final value in currentAccountId()) {
        if (value == null) {
          yield MainState.loginRequired;
        } else {
          accountId = value;
          break getAccountId;
        }
      }
    }

    String apiKey;
    getApiKey:
    while (true) {
      await for (final value in currentApiKey()) {
        if (value == null) {
          yield MainState.loginRequired;
        } else {
          apiKey = value;
          break getApiKey;
        }
      }
    }

    api.setKey(apiKey);

    while (true) {
      await Future.delayed(const Duration(seconds: 5), () {});

      Account? data;
      try {
        data = await api.account.getAccountState();
      } on ApiException catch (e) {
        print("error: $e");
        continue;
      }

      AccountState state;
      if (data == null) {
        return;
      } else {
        state = data.state;
      }

      if (state == AccountState.initialSetup) {
        yield MainState.initialSetup;
      } else if (state == AccountState.normal) {
        yield MainState.initialSetupComplete;
      } else if (state == AccountState.banned) {
        yield MainState.accountBanned;
      } else if (state == AccountState.pendingDeletion) {
        yield MainState.pendingRemoval;
      }

      break;
    }
  }

  Stream<String?> currentAccountId() async* {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    while (true) {
        var accountId = preferences.getString(KEY_ACCOUNT_ID);
        yield accountId;
        await accountIdUpdated.stream.first;
    }
  }

  Stream<String?> currentApiKey() async* {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    while (true) {
        var data = preferences.getString(KEY_API_KEY);
        yield data;
        await apiKeyUpdated.stream.first;
    }
  }

  Future<String> getAccountId() async {
    return currentAccountId()
      .where((event) => event != null)
      .map((event) => event ?? "")
      .first;
  }

  Future<String> getApiKey() async {
    return currentApiKey()
      .where((event) => event != null)
      .map((event) => event ?? "")
      .first;
  }

  Future<void> setAccountId(String accountId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_ACCOUNT_ID, accountId);
    accountIdUpdated.add(null);
  }

  Future<void> setApiKey(String apiKey) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_API_KEY, apiKey);
    apiKeyUpdated.add(null);
  }
}
