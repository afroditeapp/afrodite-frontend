import 'dart:async';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/common_repository.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';

/// This should contain account specific logic so it is not possible
/// the logic will touch another account's data if there is long running
/// operations for example. When user logs in using an account the blocs will
/// be created and the required repository instances will be get from this
/// class.
class RepositoryInstances implements DataRepositoryMethods {
  final AccountId accountId;
  final UtcDateTime creationTime = UtcDateTime.now();

  /// True only if repository was created because of manual login action.
  /// Usually this is false as usually the account is logged in when app starts.
  final bool accountLoginHappened;
  final CommonRepository common;
  final ChatRepository chat;
  final MediaRepository media;
  final ProfileRepository profile;
  final AccountRepository account;

  // No lifecycle or other methods
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountDatabaseManager accountDb;
  final ServerConnectionManager connectionManager;

  bool _logoutStarted = false;

  ApiManager get api => connectionManager;

  RepositoryInstances._({
    required this.accountId,
    required this.accountLoginHappened,
    required this.common,
    required this.chat,
    required this.media,
    required this.profile,
    required this.account,
    required this.accountBackgroundDb,
    required this.accountDb,
    required this.connectionManager,
  });

  Future<void> init() async {
    await connectionManager.init();
    await common.init();
    await chat.init();
    await media.init();
    await profile.init();
    await account.init();
  }

  Future<void> dispose() async {
    await account.dispose();
    await profile.dispose();
    await media.dispose();
    await chat.dispose();
    await common.dispose();
    await connectionManager.dispose();
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await common.onInitialSetupComplete();
    await chat.onInitialSetupComplete();
    await media.onInitialSetupComplete();
    await profile.onInitialSetupComplete();
    await account.onInitialSetupComplete();
  }

  @override
  Future<void> onLogin() async {
    await common.onLogin();
    await chat.onLogin();
    await media.onLogin();
    await profile.onLogin();
    await account.onLogin();
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await common
        .onLoginDataSync()
        .andThen((_) => chat.onLoginDataSync())
        .andThen((_) => media.onLoginDataSync())
        .andThen((_) => profile.onLoginDataSync())
        .andThen((_) => account.onLoginDataSync());
  }

  @override
  Future<void> onLogout() async {
    if (_logoutStarted) {
      return;
    }
    _logoutStarted = true;

    // Server disconnects the WebSocket when logout API request happens
    connectionManager.disableSnackBars();

    if (connectionManager.currentState == ServerConnectionState.connected) {
      final r = await api.accountAction((api) => api.postLogout());
      if (r.isErr()) {
        showSnackBar(R.strings.generic_logout_failed);
      }
    }

    await connectionManager.close();

    await accountDb.accountAction((db) => db.loginSession.updateRefreshToken(null));
    await accountDb.accountAction((db) => db.loginSession.updateAccessToken(null));

    await common.onLogout();
    await chat.onLogout();
    await media.onLogout();
    await profile.onLogout();
    await account.onLogout();
  }

  @override
  Future<void> onResumeAppUsage() async {
    await common.onResumeAppUsage();
    await chat.onResumeAppUsage();
    await media.onResumeAppUsage();
    await profile.onResumeAppUsage();
    await account.onResumeAppUsage();
  }

  static Future<RepositoryInstances> createAndInit(
    AccountId accountId, {
    bool accountLoginHappened = false,
    required String serverAddress,
  }) async {
    final accountBackgroundDb = BackgroundDatabaseManager.getInstance()
        .getAccountBackgroundDatabaseManager(accountId);
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(accountId);

    final connectionManager = ServerConnectionManager(
      serverAddress,
      accountDb,
      accountBackgroundDb,
      accountId,
    );
    final clientIdManager = ClientIdManager(accountDb, connectionManager);

    final account = AccountRepository(
      db: accountDb,
      accountBackgroundDb: accountBackgroundDb,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      rememberToInitRepositoriesLateFinal: true,
      currentUser: accountId,
    );
    final media = MediaRepository(
      account,
      accountDb,
      accountBackgroundDb,
      connectionManager,
      accountId,
    );
    final profile = ProfileRepository(
      media,
      account,
      accountDb,
      accountBackgroundDb,
      connectionManager,
      accountId,
    );
    final common = CommonRepository(accountId, connectionManager, profile);
    final chat = ChatRepository(
      media: media,
      profile: profile,
      accountBackgroundDb: accountBackgroundDb,
      db: accountDb,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      messageKeyManager: MessageKeyManager(accountDb, connectionManager, accountId),
      currentUser: accountId,
    );
    final newRepositories = RepositoryInstances._(
      accountId: accountId,
      accountLoginHappened: accountLoginHappened,
      common: common,
      chat: chat,
      media: media,
      profile: profile,
      account: account,
      accountBackgroundDb: accountBackgroundDb,
      accountDb: accountDb,
      connectionManager: connectionManager,
    );
    account.repositories = newRepositories;
    await newRepositories.init();

    return newRepositories;
  }
}
