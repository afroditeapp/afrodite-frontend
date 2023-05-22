


import 'dart:async';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


const KEY_ACCOUNT_ID = "account-id";
const KEY_ACCOUNT_CAPABLITIES = "account-capablities";
const KEY_API_KEY = "api-key";
const KEY_ACCOUNT_STATE = "account-state";
const KEY_SERVER_ADDRESS = "server-address";

class AccountRepository {
  final ApiProvider api;
  final BehaviorSubject<void> accountIdUpdated = BehaviorSubject.seeded(null);
  final BehaviorSubject<void> apiKeyUpdated = BehaviorSubject.seeded(null);
  final PublishSubject<void> accountStateUpdated = PublishSubject();

  final BehaviorSubject<Capabilities> _capablities = BehaviorSubject.seeded(Capabilities());

  Stream<Capabilities> get capabilities {
    return _capablities.distinct();
  }

  AccountRepository(this.api);

  Stream<MainState> accountState() async* {
    yield MainState.splashScreen;

    // Load previously saved server address
    print(await getCurrentServerAddress());

    print("Waiting AccountId");

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

    print("Waiting ApiKey");

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
    print("ApiKey received.");

    api.setKey(apiKey);

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final previousStateString = preferences.getString(KEY_ACCOUNT_STATE);
    var previousState = AccountState.initialSetup;
    if (previousStateString != null) {
      previousState = AccountState.fromJson(previousStateString) ?? previousState;
    }

    final previousCapablitiesString = preferences.getString(KEY_ACCOUNT_CAPABLITIES);
    if (previousCapablitiesString != null) {
      final c = Capabilities.fromJson(previousCapablitiesString) ?? Capabilities();
      _capablities.add(c);
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
        await Future.any([
          Future.delayed(const Duration(seconds: 5), () {}),
        ]);
        data = await api.account.getAccountState();
      } on ApiException catch (e) {
        print("error: $e");
        continue;
      }

      if (data == null) {
        print("error: data == null");
        continue;
      } else {
        print(data.state);
        state = data.state;

        if (_capablities.value != data.capablities) {
          _capablities.add(data.capablities);
          await preferences.setString(KEY_ACCOUNT_CAPABLITIES, data.capablities.toString());
        }
      }

      if (previousState != state) {
        if (state == AccountState.initialSetup) {
          yield MainState.initialSetup;
        } else if (state == AccountState.normal) {
          yield MainState.initialSetupComplete;
        } else if (state == AccountState.banned) {
          yield MainState.accountBanned;
        } else if (state == AccountState.pendingDeletion) {
          yield MainState.pendingRemoval;
        }
        await preferences.setString(KEY_ACCOUNT_STATE, state.toString());
      }

      await Future.any([
        Future.delayed(const Duration(seconds: 5), () {}),
        accountStateUpdated.stream.first
      ]);
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

    await for (final _ in apiKeyUpdated) {
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
    print("Set API key");
  }

  Future<AccountIdLight?> register() async {
    var id = await api.account.postRegister();
    if (id != null) {
      await setAccountId(id);
    }
    return id;
  }

  Future<ApiKey?> login() async {
    final loginResult = await api.account.postLogin(await getAccountId());
    if (loginResult != null) {
      await setApiKey(loginResult.account.access);
    }
    return loginResult?.account.access;
  }

  Future<String?> doInitialSetup(String email, String name, XFile securitySelfie, XFile profileImage) async {
    final securitySelfiePath = securitySelfie.path;
    final profileImagePath = profileImage.path;
    try {
      await api.account.postAccountSetup(AccountSetup(email: email, name: name));
      final securitySelfie = await MultipartFile.fromPath("", securitySelfiePath);
      final contentId1 = await api.media.putImageToModerationSlot(0, securitySelfie);
      if (contentId1 == null) {
        return "Server did not return content ID";
      }
      final profileImage = await MultipartFile.fromPath("", profileImagePath);
      final contentId2 = await api.media.putImageToModerationSlot(1, profileImage);
      if (contentId2 == null) {
        return "Server did not return content ID";
      }
      await api.media.putModerationRequest(ModerationRequestContent(cameraImage: true, image1: contentId1, image2: contentId2));
      await api.account.postCompleteSetup();
      accountStateUpdated.add(null);
    } on ApiException catch (e) {
      print(e);
      return "Error";
    }

    return null;
  }

  Future<String> getCurrentServerAddress() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final address = await preferences.getString(KEY_SERVER_ADDRESS);
    if (address == null) {
      return api.serverAddress;
    } else {
      if (address != api.serverAddress) {
        api.updateServerAddress(address);
      }
      return address;
    }
  }

  Future<void> setCurrentServerAddress(String serverAddress) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_SERVER_ADDRESS, serverAddress);
    api.updateServerAddress(serverAddress);
  }
}
