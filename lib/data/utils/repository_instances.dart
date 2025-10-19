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
class RepositoryInstances {
  final AccountId accountId;
  final UtcDateTime creationTime = UtcDateTime.now();

  /// True only if repository was created because of manual login action.
  /// Usually this is false as usually the account is logged in when app starts.
  final bool accountLoginHappened;
  final CommonRepository common;
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;
  final ChatRepository chat;

  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountDatabaseManager accountDb;
  final ServerConnectionManager connectionManager;
  final ClientIdManager clientIdManager;
  final MessageKeyManager messageKeyManager;

  bool _logoutStarted = false;

  ApiManager get api => connectionManager;

  RepositoryInstances._({
    required this.accountId,
    required this.accountLoginHappened,
    required this.common,
    required this.account,
    required this.profile,
    required this.media,
    required this.chat,
    required this.accountBackgroundDb,
    required this.accountDb,
    required this.connectionManager,
    required this.clientIdManager,
    required this.messageKeyManager,
  });

  List<DataRepositoryWithLifecycle> get _repositories => [common, account, profile, media, chat];

  Future<void> init() async {
    await connectionManager.init();
    for (final r in _repositories) {
      await r.init();
    }
  }

  Future<void> onInitialSetupComplete() async {
    for (final r in _repositories) {
      await r.onInitialSetupComplete();
    }
  }

  Future<void> onLogin() async {
    for (final r in _repositories) {
      await r.onLogin();
    }
  }

  Future<Result<(), ()>> onLoginDataSync() async {
    for (final r in _repositories) {
      if (await r.onLoginDataSync().isErr()) {
        return Err(());
      }
    }
    return Ok(());
  }

  Future<void> onResumeAppUsage() async {
    for (final r in _repositories) {
      await r.onResumeAppUsage();
    }
  }

  Future<void> logoutAndDispose() async {
    if (_logoutStarted) {
      return;
    }
    _logoutStarted = true;

    // Server disconnects the WebSocket when logout API request happens
    connectionManager.disableSnackBars();

    if (connectionManager.currentState is ConnectedToServer) {
      final r = await api.accountAction((api) => api.postLogout());
      if (r.isErr()) {
        showSnackBar(R.strings.generic_logout_failed);
      }
    }

    await connectionManager.close();

    await accountDb.accountAction((db) => db.loginSession.updateRefreshToken(null));
    await accountDb.accountAction((db) => db.loginSession.updateAccessToken(null));

    for (final r in _repositories) {
      await r.onLogout();
    }

    for (final r in _repositories) {
      await r.dispose();
    }

    await connectionManager.dispose();
    await clientIdManager.dispose();
    await messageKeyManager.dispose();

    await accountBackgroundDb.close();
    await accountDb.close();
  }

  static Future<RepositoryInstances> createAndInit(
    AccountId accountId, {
    bool accountLoginHappened = false,
    required String serverAddress,
  }) async {
    final accountBackgroundDb = await BackgroundDatabaseManager.getInstance()
        .getAccountBackgroundDatabaseManager(accountId);
    final accountDb = await DatabaseManager.getInstance().getAccountDatabaseManager(accountId);

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
    final common = CommonRepository(accountId, accountBackgroundDb, connectionManager, profile);
    final messageKeyManager = MessageKeyManager(accountDb, connectionManager, accountId);
    final chat = ChatRepository(
      media: media,
      profile: profile,
      accountBackgroundDb: accountBackgroundDb,
      db: accountDb,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      messageKeyManager: messageKeyManager,
      currentUser: accountId,
    );
    final newRepositories = RepositoryInstances._(
      accountId: accountId,
      accountLoginHappened: accountLoginHappened,
      common: common,
      account: account,
      profile: profile,
      media: media,
      chat: chat,
      accountBackgroundDb: accountBackgroundDb,
      accountDb: accountDb,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      messageKeyManager: messageKeyManager,
    );
    account.repositories = newRepositories;
    await newRepositories.init();

    return newRepositories;
  }
}
