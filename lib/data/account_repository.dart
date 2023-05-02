


import 'dart:async';

import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


const KEY_ACCOUNT_ID = "account-id";
const KEY_API_KEY = "api-key";
const KEY_ACCOUNT_STATE = "account-state";

class AccountRepository {
  final ApiProvider api;
  final BehaviorSubject<void> accountIdUpdated = BehaviorSubject.seeded(null);
  final BehaviorSubject<void> apiKeyUpdated = BehaviorSubject.seeded(null);

  AccountRepository(this.api);

  Stream<MainState> accountState() async* {
    yield MainState.splashScreen;

    await Future.delayed(const Duration(seconds: 1), () {});

    AccountIdLight accountId;
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

    ApiKey apiKey;
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

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final previousStateString = preferences.getString(KEY_ACCOUNT_STATE);
    var previousState = AccountState.initialSetup;
    if (previousStateString != null) {
      previousState = AccountState.fromJson(previousStateString) ?? previousState;
    }

    var state = previousState;
    while (true) {
      if (state == AccountState.initialSetup) {
        yield MainState.initialSetup;
      } else if (state == AccountState.normal) {
        yield MainState.initialSetupComplete;
      } else if (state == AccountState.banned) {
        yield MainState.accountBanned;
      } else if (state == AccountState.pendingDeletion) {
        yield MainState.pendingRemoval;
      }

      Account? data;
      try {
        data = await api.account.getAccountState();
      } on ApiException catch (e) {
        print("error: $e");
        continue;
      }

      if (data == null) {
        continue;
      } else {
        state = data.state;
      }

      if (previousState != state) {
        await preferences.setString(KEY_ACCOUNT_STATE, state.toString());
      }

      await Future.delayed(const Duration(seconds: 5), () {});
    }
  }

  Stream<AccountIdLight?> currentAccountId() async* {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await for (final _ in accountIdUpdated) {
      var accountId = preferences.getString(KEY_ACCOUNT_ID);
      if (accountId != null) {
        yield AccountIdLight(accountId: accountId);
      } else {
        yield null;
      }
    }
  }

  Stream<ApiKey?> currentApiKey() async* {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await for (final _ in accountIdUpdated) {
      var data = preferences.getString(KEY_API_KEY);
      if (data != null) {
        yield ApiKey(apiKey: data);
      } else {
        yield null;
      }
    }
  }

  Future<AccountIdLight> getAccountId() async {
    return currentAccountId()
      .whereNotNull()
      .first;
  }

  Future<ApiKey> getApiKey() async {
    return currentApiKey()
      .whereNotNull()
      .first;
  }

  Future<void> setAccountId(AccountIdLight accountId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_ACCOUNT_ID, accountId.accountId);
    accountIdUpdated.add(null);
    print("Set account id");
  }

  Future<void> setApiKey(ApiKey apiKey) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_API_KEY, apiKey.apiKey);
    apiKeyUpdated.add(null);
  }

  Future<void> register() async {
    var id = await api.account.postRegister();
    if (id != null) {
      await setAccountId(id);
    }
  }

  Future<void> login() async {
    var key = await api.account.postLogin(await getAccountId());
    if (key != null) {
      await setApiKey(key);
    }
  }
}
