import 'dart:async';

import 'package:app/data/app_version.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/utils/app_error.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("DemoAccountManager");

class DemoAccountManager {
  final BehaviorSubject<bool> _demoAccountLoginProgress = BehaviorSubject.seeded(false);

  // Demo account
  Stream<String?> get demoAccountUsername =>
      DatabaseManager.getInstance().commonStream((db) => db.demoAccount.watchDemoAccountUsername());

  Stream<String?> get demoAccountPassword =>
      DatabaseManager.getInstance().commonStream((db) => db.demoAccount.watchDemoAccountPassword());

  Stream<String?> get demoAccountToken =>
      DatabaseManager.getInstance().commonStream((db) => db.demoAccount.watchDemoAccountToken());
  Stream<bool> get demoAccountLoginProgress => _demoAccountLoginProgress;

  Future<Result<(), DemoAccountLoginError>> demoAccountLogin(
    DemoAccountCredentials credentials, {
    required ApiManager apiNoConnection,
  }) async {
    _demoAccountLoginProgress.add(true);
    final loginResult = await apiNoConnection
        .account(
          (api) => api.postDemoAccountLogin(
            DemoAccountLoginCredentials(
              username: credentials.username,
              password: credentials.password,
            ),
          ),
        )
        .ok();
    _demoAccountLoginProgress.add(false);

    if (loginResult == null) {
      return const Err(DemoAccountLoginError.otherError);
    }

    if (loginResult.locked) {
      return const Err(DemoAccountLoginError.accountLocked);
    }

    final demoAccountToken = loginResult.token?.token;
    if (demoAccountToken == null) {
      return const Err(DemoAccountLoginError.otherError);
    }

    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountUsername(credentials.username),
    );
    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountPassword(credentials.password),
    );
    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountToken(demoAccountToken),
    );

    return const Ok(());
  }

  Future<void> demoAccountLogout({required ApiManager apiNoConnection}) async {
    _log.info("demo account logout");

    final token = await demoAccountToken.first;
    if (token != null) {
      final r = await apiNoConnection.accountAction(
        (api) => api.postDemoAccountLogout(DemoAccountToken(token: token)),
      );
      if (r.isErr()) {
        showSnackBar(R.strings.generic_logout_failed);
      }
    }

    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountToken(null),
    );

    _log.info("demo account logout completed");
  }

  Future<Result<DemoAccountToken, DemoAccountError>> _getCurrentToken() async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(DemoAccountLoggedOutFromDemoAccount());
    } else {
      return Ok(DemoAccountToken(token: token));
    }
  }

  Future<DemoAccountError> handleError(
    ValueApiError e, {
    required ApiManager apiNoConnection,
  }) async {
    if (e.isUnauthorized()) {
      await demoAccountLogout(apiNoConnection: apiNoConnection);
      return DemoAccountSessionExpired();
    } else {
      return DemoAccountSignInError(CommonSignInError.otherError);
    }
  }

  Future<Result<List<AccessibleAccount>, DemoAccountError>> demoAccountGetAccounts({
    required ApiManager apiNoConnection,
  }) async {
    return await _getCurrentToken().andThen(
      (t) => apiNoConnection
          .accountWrapper()
          .requestValue((api) => api.postDemoAccountAccessibleAccounts(t))
          .mapErr((e) => handleError(e, apiNoConnection: apiNoConnection)),
    );
  }

  Future<Result<LoginResult, DemoAccountError>> demoAccountRegisterIfNeededAndLogin({
    required AccountId? id,
    required ApiManager apiNoConnection,
  }) async {
    return await _getCurrentToken()
        .andThen((t) async {
          if (id != null) {
            return Ok(id);
          } else {
            return await apiNoConnection
                .accountWrapper()
                .requestValue((api) => api.postDemoAccountRegisterAccount(t))
                .mapErr((e) => handleError(e, apiNoConnection: apiNoConnection))
                .andThen((r) {
                  final aid = r.aid;
                  if (r.errorMaxAccountCount) {
                    return Err<AccountId, DemoAccountError>(DemoAccountMaxAccountCountError());
                  } else if (r.error || aid == null) {
                    return Err<AccountId, DemoAccountError>(DemoAccountGeneralError());
                  } else {
                    return Ok(aid);
                  }
                });
          }
        })
        .andThen(
          (account) => _demoAccountLoginToAccount(account, apiNoConnection: apiNoConnection),
        );
  }

  Future<Result<LoginResult, DemoAccountError>> _demoAccountLoginToAccount(
    AccountId id, {
    required ApiManager apiNoConnection,
  }) async {
    return await _getCurrentToken().andThen(
      (t) => apiNoConnection
          .accountWrapper()
          .requestValue(
            (api) => api.postDemoAccountLoginToAccount(
              DemoAccountLoginToAccount(
                aid: id,
                token: t,
                clientInfo: AppVersionManager.getInstance().clientInfo(),
              ),
            ),
          )
          .mapErr((e) => handleError(e, apiNoConnection: apiNoConnection)),
    );
  }
}

class DemoAccountCredentials {
  final String username;
  final String password;
  DemoAccountCredentials(this.username, this.password);
}

enum DemoAccountLoginError { accountLocked, otherError }
