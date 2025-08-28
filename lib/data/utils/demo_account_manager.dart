import 'dart:async';

import 'package:app/data/app_version.dart';
import 'package:app/data/login_repository.dart';
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

  Future<Result<List<AccessibleAccount>, SessionOrOtherError>> demoAccountGetAccounts({
    required ApiManager apiNoConnection,
  }) async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final accounts = await apiNoConnection.accountWrapper().requestValue(
      (api) => api.postDemoAccountAccessibleAccounts(DemoAccountToken(token: token)),
    );
    switch (accounts) {
      case Ok(:final v):
        return Ok(v);
      case Err(:final e):
        if (e.isUnauthorized()) {
          await demoAccountLogout(apiNoConnection: apiNoConnection);
          return Err(SessionExpired());
        } else {
          return Err(OtherError());
        }
    }
  }

  Future<Result<LoginResult, SessionOrOtherError>> demoAccountRegisterIfNeededAndLogin({
    required AccountId? id,
    required ApiManager apiNoConnection,
  }) async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoAccountToken(token: token);

    AccountId account;
    if (id != null) {
      account = id;
    } else {
      final r = await apiNoConnection.accountWrapper().requestValue(
        (api) => api.postDemoAccountRegisterAccount(demoToken),
      );
      switch (r) {
        case Ok(:final v):
          account = v;
        case Err(:final e):
          if (e.isUnauthorized()) {
            await demoAccountLogout(apiNoConnection: apiNoConnection);
            return Err(SessionExpired());
          } else {
            return Err(OtherError());
          }
      }
    }

    return await _demoAccountLoginToAccount(account, apiNoConnection: apiNoConnection);
  }

  Future<Result<LoginResult, SessionOrOtherError>> _demoAccountLoginToAccount(
    AccountId id, {
    required ApiManager apiNoConnection,
  }) async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoAccountToken(token: token);
    final loginResult = await apiNoConnection.accountWrapper().requestValue(
      (api) => api.postDemoAccountLoginToAccount(
        DemoAccountLoginToAccount(
          aid: id,
          token: demoToken,
          clientInfo: AppVersionManager.getInstance().clientInfo(),
        ),
      ),
    );
    switch (loginResult) {
      case Ok(:final v):
        return Ok(v);
      case Err(:final e):
        if (e.isUnauthorized()) {
          await demoAccountLogout(apiNoConnection: apiNoConnection);
          return Err(SessionExpired());
        } else {
          return Err(OtherError());
        }
    }
  }
}

class DemoAccountCredentials {
  final String username;
  final String password;
  DemoAccountCredentials(this.username, this.password);
}

enum DemoAccountLoginError { accountLocked, otherError }
