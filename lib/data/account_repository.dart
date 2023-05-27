


import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AccountRepositoryState {
  initRequired,
}

class AccountRepository {
  final api = ApiManager.getInstance();

  final BehaviorSubject<MainState> _mainState =
    BehaviorSubject.seeded(MainState.splashScreen);
  final BehaviorSubject<AccountRepositoryState> _internalState =
    BehaviorSubject.seeded(AccountRepositoryState.initRequired);

  final PublishSubject<void> hintAccountStateUpdated = PublishSubject();

  final _accountState = KvStorageManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountState,
      (value) => AccountState.fromJson(value) ?? AccountState.initialSetup,
      AccountState.initialSetup,
    );
  final _capablities = KvStorageManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountCapabilities,
      (value) {
         final map = jsonDecode(value);
        if (map != null) {
          return Capabilities.fromJson(map) ?? Capabilities();
        } else {
          return Capabilities();
        }
      },
      Capabilities(),
    );
  final _accountId = KvStorageManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountId,
      (value) => AccountIdLight(accountId: value)
    );
  final _accountAccessToken = KvStorageManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.mediaAccessToken,
      (value) => ApiKey(apiKey: value)
    );

  Stream<MainState> get mainState => _mainState.distinct();

  Stream<AccountState> get accountState => _accountState.distinct();
  Stream<Capabilities> get capabilities => _capablities.distinct();
  Stream<AccountIdLight?> get accountId => _accountId.distinct();
  Stream<ApiKey?> get accountAccessToken => _accountAccessToken.distinct();

  AccountRepository();

  void init() {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }

    _accountStateUpdating().then((value) => null);
  }

  Future<void> _accountStateUpdating() async {
    _mainState.add(MainState.splashScreen);

    print("Waiting AccountId");
    await for (final value in accountId) {
      if (value == null) {
        _mainState.add(MainState.loginRequired);
      } else {
        break;
      }
    }
    print("AccountId received.");

    print("Waiting accountAccessToken");
    await for (final value in accountAccessToken) {
      if (value == null) {
        _mainState.add(MainState.loginRequired);
      } else {
        break;
      }
    }
    print("accountAccessToken received.");

    var previousState = await accountState.first;
    var state = previousState;

    emitStateUpdates(state);

    while (true) {
      Account? data = await api.account((api) => api.getAccountState());

      if (data == null) {
        print("error: data == null");
      } else {
        print(data.state);
        state = data.state;

        if (_capablities.value != data.capablities) {
          await KvStorageManager.getInstance().setString(KvString.accountCapabilities, data.capablities.toString());
        }

        if (previousState != state) {
          await KvStorageManager.getInstance().setString(KvString.accountState, state.toString());
          emitStateUpdates(state);
        }
      }

      await Future.any([
        Future.delayed(const Duration(seconds: 5), () {}),
        hintAccountStateUpdated.stream.first
      ]);
    }
  }

  void emitStateUpdates(AccountState state) {
      if (state == AccountState.initialSetup) {
        _mainState.add(MainState.initialSetup);
      } else if (state == AccountState.normal) {
        _mainState.add(MainState.initialSetupComplete);
      } else if (state == AccountState.banned) {
        _mainState.add(MainState.accountBanned);
      } else if (state == AccountState.pendingDeletion) {
        _mainState.add(MainState.pendingRemoval);
      }
  }

  Future<AccountIdLight?> register() async {
    var id = await api.account((api) => api.postRegister());
    if (id != null) {
      await KvStorageManager.getInstance().setString(KvString.accountId, id.accountId);
    }
    return id;
  }

  Future<ApiKey?> login() async {
    final accountIdValue = await accountId.first;
    if (accountIdValue == null) {
      return null;
    }
    final loginResult = await api.account((api) => api.postLogin(accountIdValue));
    if (loginResult != null) {
      await KvStorageManager.getInstance().setString(KvString.accountRefreshToken, loginResult.account.refresh.token);
      await KvStorageManager.getInstance().setString(KvString.accountAccessToken, loginResult.account.access.apiKey);
    }
    await api.restart();
    return loginResult?.account.access;
  }

  /// Return null on success. Return String if error.
  Future<String?> doInitialSetup(String email, String name, XFile securitySelfieFile, XFile profileImageFile) async {
    final String securitySelfiePath = securitySelfieFile.path;
    final String profileImagePath = profileImageFile.path;

    await api.account((api) => api.postAccountSetup(AccountSetup(email: email, name: name)));
    final securitySelfie = await MultipartFile.fromPath("", securitySelfiePath);
    final contentId1 = await api.media((api) => api.putImageToModerationSlot(0, securitySelfie));
    if (contentId1 == null) {
      return "Server did not return content ID";
    }
    final profileImage = await MultipartFile.fromPath("", profileImagePath);
    final contentId2 = await api.media((api) => api.putImageToModerationSlot(1, profileImage));
    if (contentId2 == null) {
      return "Server did not return content ID";
    }
    await api.media((api) => api.putModerationRequest(ModerationRequestContent(cameraImage: true, image1: contentId1, image2: contentId2)));
    await api.account((api) => api.postCompleteSetup());
    hintAccountStateUpdated.add(null);

    final state = await api.account((api) => api.getAccountState());
    if (state == null || state.state != AccountState.normal) {
      return "Error";
    }

    return null;
  }

  Future<String> getCurrentServerAddress() async {
    return await ConfigManager.getInstance().getString(
      ConfigStringKey.accountServerAddress
    );
  }

  Future<void> setCurrentServerAddress(String serverAddress) async {
    await ConfigManager.getInstance().setString(
      ConfigStringKey.accountServerAddress, serverAddress
    );
    await ApiManager.getInstance().restart();
  }

  Future<void> signInWithGoogle(GoogleSignIn google) async {
     final signedIn = await google.signIn();
      if (signedIn != null) {
        print(signedIn.toString());
        print(signedIn.email.toString());

        var token = await signedIn.authentication;
        print(token.accessToken);
        print(token.idToken);

        await api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken)));
      }
  }

  Future<void> signOutFromGoogle(GoogleSignIn google) async {
    final signedIn = await google.disconnect();
    print(signedIn);
    if (signedIn != null) {
      print(signedIn.toString());
      print(signedIn.email.toString());
    }
  }

  Future<void> signInWithApple() async {
     AuthorizationCredentialAppleID signedIn;
    try {
      signedIn = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
      ]);
      print(signedIn);
      await api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(appleToken: signedIn.identityToken)));
    } on SignInWithAppleException catch (e) {
      print(e);
    }
  }
}
